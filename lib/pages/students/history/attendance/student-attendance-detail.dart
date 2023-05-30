// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, avoid_print, file_names
import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:googleapis/blogger/v3.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/pages/students/history/attendance/comment-page.dart';
import 'package:sister_mobile/pages/students/history/attendance/logview-page.dart';
import 'package:sister_mobile/pages/students/history/attendance/student-attendance-history.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentAttendanceDetailPage extends StatefulWidget {
  String? name;
  String? date;
  String? status;
  String? growthPoint;
  String? comment;
  String? lesson;
  String? videoUrl;

  StudentAttendanceDetailPage({
    Key? key,
    this.name,
    this.date,
    this.status,
    this.growthPoint,
    this.comment,
    this.lesson,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<StudentAttendanceDetailPage> createState() =>
      _StudentAttendanceDetailPageState();
}

class _StudentAttendanceDetailPageState
    extends State<StudentAttendanceDetailPage> {
  final _growthController = TextEditingController();
  final _commentsController = TextEditingController();
  final _lessonController = TextEditingController();
  final _urlController = TextEditingController();

  var viewTotal;

  final cookieJar = CookieJar();
  final dio = Dio();

  final commentController = TextEditingController();

  var userEmail;

  @override
  void initState() {
    super.initState();
    _fetchComment();
    _fetchViewlog();
  }

  @override
  Widget build(BuildContext context) {
    return _buildStudentAttendancePage();
  }

  var listComment = [];

  Widget _buildStudentAttendancePage() {
    _setValue();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 29, 37),
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        shadowColor: sBlackColor,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LogviewPage(attendance: widget.name)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.remove_red_eye_outlined, color: sWhiteColor),
                SizedBox(width: 5),
                Text(
                    viewTotal.toString() == 'null' ? '0' : viewTotal.toString(),
                    style: sWhiteTextStyle.copyWith(fontSize: 16)),
                SizedBox(width: 20),
              ],
            ),
          )
        ],
        backgroundColor: Color.fromARGB(255, 23, 29, 37),
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Attendance Detail',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleDetail(),
              const SizedBox(height: 30),
              _buildAttendanceDetailForm(),
              const SizedBox(height: 5),
              _buildCommentSection()
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildTitleDetail() {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(
              widget.name.toString(),
              style: sWhiteTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 20,
              ),
            ),
            Material(
              color: sBlackColor,
              child: InkWell(
                splashColor: sGreyColor,
                borderRadius: BorderRadius.circular(4),
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 20,
                  width: 70,
                  decoration: BoxDecoration(
                    color: sGreenColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                      child: Text(
                    widget.status.toString(),
                    style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                  )),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 5),
          Text(widget.date.toString(), style: fTextColorStyle),
        ],
      ),
    );
  }

  Widget _buildAttendanceDetailForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! Growth Point Field
          Text('Growth Point', style: fTextColorStyle),
          const SizedBox(height: 5),
          RatingBar.builder(
            initialRating: double.parse(_growthController.text),
            minRating: 0,
            itemSize: 40,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            unratedColor: Color(0XFF444C56),
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Color.fromARGB(255, 151, 141, 27),
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
          const SizedBox(height: 15),

          // ! Lesson Field
          Text('Lesson', style: fTextColorStyle),
          const SizedBox(height: 10),
          Container(
            height: 50,
            child: TextFormField(
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              style: sWhiteTextStyle,
              controller: _lessonController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.only(left: 15),
                fillColor: sBlackColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFF444C56)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFF444C56)),
                ),
                hintText: 'e.x place',
                hintStyle: fGreyTextStyle,
              ),
            ),
          ),
          const SizedBox(height: 15),

          // ! Comment Fields
          Text('Comment', style: fTextColorStyle),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(widget.videoUrl.toString()));
            },
            child: Container(
              height: 50,
              child: TextFormField(
                readOnly: true,
                style: sWhiteTextStyle,
                controller: _commentsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 15),
                  fillColor: sBlackColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0XFF444C56)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0XFF444C56)),
                  ),
                  hintText: 'e.x comment',
                  hintStyle: fGreyTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),

          // ! Video Url Fields
          Text('Video Url', style: fTextColorStyle),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(widget.videoUrl.toString()));
            },
            child: Container(
              height: 50,
              child: TextFormField(
                readOnly: true,
                style: sWhiteTextStyle,
                controller: _urlController,
                textAlignVertical: TextAlignVertical.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: EdgeInsets.only(left: 15),
                  fillColor: sBlackColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0XFF444C56)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0XFF444C56)),
                  ),
                  hintText: "URL isn't avaliable",
                  hintStyle: fGreyTextStyle,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildCommentSection() {
    return Container(
      color: sGreyColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Text('Response', style: fGreyTextStyle),
          SizedBox(height: 10),
          Container(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: commentController,
              style: sWhiteTextStyle,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 15),
                suffixIcon: GestureDetector(
                    onTap: () => _sendComment(),
                    child: Icon(
                      Icons.send,
                      color: sWhiteColor,
                      size: 20,
                    )),
                filled: true,
                fillColor: sBlackColor,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFF444C56)),
                ),
                hintText: 'Write your Response Here',
                hintStyle: fGreyTextStyle,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: <Widget>[
              ...listComment.map((item) {
                return _commentCard(item);
              }).toList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _commentCard(item) {
    return GestureDetector(
      onTap: () {
        if (item['seen'].toString() != '1') {
          _sendSeenComment(item['name']);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CommentPage(
                      content: item['content'],
                      code: item['name'],
                      schedule: widget.name,
                      owner: userEmail == item['comment_email'] ? true : false,
                    )));
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['comment_by'].toString(),
                        style: sWhiteTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          'Seen at 4 July 2023 ',
                          style: sGreyTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Color(0XFF444C56),
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: sGreyColor,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(
                    item['content'].toString(),
                    style: sGreyTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  _fetchViewlog() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    var viewlogCode = [];
    var viewlogList = [];

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });

    var getViewlog = await dio
        .get('https://njajal.sekolahmusik.co.id/api/resource/View Log/');

    for (var i = 0; i < getViewlog.data['data'].length; i++) {
      viewlogCode.add(getViewlog.data['data'][i]);
    }

    print(viewlogCode.length.toString());

    for (var a = 0; a < viewlogCode.length; a++) {
      final response = await dio.get(
          'https://${baseUrl}.sekolahmusik.co.id/api/resource/View Log/${viewlogCode[a]['name']}');

      if (response.data['data']['reference_name'] == widget.name) {
        viewlogList.add(1);
      }
    }

    if (mounted) {
      setState(() {
        viewTotal = viewlogList.length;
      });
    }
  }

  _fetchComment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    var email = pref.getString('user-email');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    final getCommentName = await dio.get(
        'https://${baseUrl}.sekolahmusik.co.id/api/resource/Comment?filters=[["reference_doctype","=","Student Attendance"], ["comment_type","=","comment"]]&fields=["name","content","reference_name","comment_by","seen", "comment_email"]');

    print('response : ' + getCommentName.toString());

    if (mounted) {
      setState(() {
        userEmail = email;
      });
    }

    if (getCommentName.statusCode == 200) {
      for (var i = 0; i < getCommentName.data['data'].length; i++) {
        if (getCommentName.data['data'][i]['reference_name'] ==
            widget.name.toString()) {
          if (mounted) {
            setState(() {
              listComment.add(getCommentName.data['data'][i]);
            });
          }
        }
      }
    } else {
      print('ersponse : error');
    }
  }

  _sendComment() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    var email = pref.getString('user-email');

    print('0');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    print('1');

    final sendComment = await dio.post(
        'https://${baseUrl}.sekolahmusik.co.id/api/resource/Comment',
        data: {
          "doctype": "Comment",
          "comment_type": "Comment",
          "reference_doctype": "Student Attendance",
          "reference_name": widget.name,
          "content": commentController.text
        });

    print('2');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StudentAttendanceHistoryPage()),
        (route) => false);
    // Navigator.pop(context);
  }

  _sendSeenComment(code) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    var email = pref.getString('user-email');

    print('0');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    print('1');

    final seenComment = await dio.put(
        'https://${baseUrl}.sekolahmusik.co.id/api/resource/Comment/${code}',
        data: {
          'seen': '1',
        });

    print('seen');
  }

  _setValue() {
    _growthController.text = widget.growthPoint.toString();
    _lessonController.text = widget.lesson.toString();
    _commentsController.text = widget.comment.toString();
    _urlController.text = widget.videoUrl.toString();
  }
}
