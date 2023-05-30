import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/pages/students/history/attendance/student-attendance-detail.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class CommentPage extends StatefulWidget {
  var content;
  var code;
  var schedule;
  var owner = false;

  CommentPage(
      {super.key,
      required this.content,
      required this.code,
      required this.schedule,
      required this.owner});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var userEmail;
  var listComment = [];
  var content;

  bool isLoading = true;
  bool sending = false;

  final dio = Dio();
  final cookieJar = CookieJar();

  final editCommentController = TextEditingController();

  @override
  void initState() {
    setState(() {
      content = widget.content.toString();
      editCommentController.text = widget.content.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  _buildScaffold() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        actions: [
          widget.owner == true
              ? Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.edit, color: sBlueColor),
                      onTap: () {
                        bottomSheet();
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Icon(Icons.delete, color: sRedColor),
                      onTap: () {
                        _deleteComment();
                      },
                    ),
                    SizedBox(width: 20),
                  ],
                )
              : Container()
        ],
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Comment Detail',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildContent(),
                ],
              )),
        ),
      ),
    );
  }

  _buildContent() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: sending == true
          ? Text('Updating your comment...', style: sGreyTextStyle.copyWith())
          : Text(content, style: sWhiteTextStyle.copyWith()),
    );
  }

  _editComment() async {
    Navigator.pop(context);

    if (mounted) {
      setState(() {
        sending = true;
      });
    }

    SharedPreferences pref = await SharedPreferences.getInstance();
    print('schedule : ' + widget.schedule.toString());
    print('content : ' + editCommentController.text.toString());

    var user = pref.getString("username");
    var pass = pref.getString('password');

    print('user : ' + user.toString());
    print('password : ' + pass.toString());

    var email = pref.getString('user-email');

    print('0');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    print('1');

    final editComment = await dio.put(
        "https://${baseUrl}.sekolahmusik.co.id/api/resource/Comment/${widget.code}",
        data: {
          'content': editCommentController.text,
        });

    print('2');

    Navigator.pop(context);

    Navigator.pop(context);
  }

  _deleteComment() async {
    if (mounted) {
      setState(() => sending = true);
    }
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    print('0');

    final deleteComment = await dio.delete(
      "https://${baseUrl}.sekolahmusik.co.id/api/resource/Comment/${widget.code}",
    );

    print('1');

    Navigator.pop(context);

    Navigator.pop(context);
  }

  bottomSheet() {
    showModalBottomSheet(
      backgroundColor: sGreyColor,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Comment Detail',
                  style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: sGreyTextStyle,
                  controller: editCommentController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: sBlackColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0XFF444C56)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Color(0XFF444C56)),
                    ),
                    hintText: 'Edit your Comment Here',
                    hintStyle: fGreyTextStyle,
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  color: const Color(0xffE22426),
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () async {
                      _editComment();
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                          child: sending == true
                              ? CircularProgressIndicator(
                                  color: sWhiteColor,
                                )
                              : Text(
                                  'Edit',
                                  style: GoogleFonts.openSans(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
