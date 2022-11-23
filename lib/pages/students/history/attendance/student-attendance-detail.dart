// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sister_mobile/model/Attendance-model.dart';
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

  @override
  Widget build(BuildContext context) {
    return _buildStudentAttendancePage();
  }

  Widget _buildStudentAttendancePage() {
    _setValue();
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
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
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleDetail(),
                  const SizedBox(height: 30),
                  _buildAttendanceDetailForm(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildTitleDetail() {
    return SizedBox(
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
                  margin: EdgeInsets.only(left: 5),
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
          SizedBox(height: 10),
          Text(widget.date.toString(), style: fTextColorStyle),
        ],
      ),
    );
  }

  Widget _buildAttendanceDetailForm() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! Growth Point Field
          Text('Growth Point', style: fTextColorStyle),
          const SizedBox(height: 5),
          RatingBar.builder(
            initialRating: double.parse(_growthController.text),
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Color.fromARGB(255, 151, 141, 27),
            ),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),

          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _growthController,
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
              hintText: 'e.x instructor',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Comment Field
          Text('Comment', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _commentsController,
            maxLines: 5,
            keyboardType: TextInputType.number,
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
              hintText: 'e.x comment',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Lesson Field
          Text('Lesson', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _lessonController,
            keyboardType: TextInputType.number,
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
              hintText: 'e.x place',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Video Url Field
          Text('Video Url', style: fTextColorStyle),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              launchUrl(Uri.parse(widget.videoUrl.toString()));
            },
            child: TextFormField(
              readOnly: true,
              style: sGreyTextStyle,
              controller: _urlController,
              keyboardType: TextInputType.number,
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
                hintText: 'e.x place',
                hintStyle: fGreyTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _setValue() {
    _growthController.text = widget.growthPoint.toString();
    _lessonController.text = widget.lesson.toString();
    _commentsController.text = widget.comment.toString();
    _urlController.text = widget.videoUrl.toString();
  }
}
