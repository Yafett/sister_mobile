import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentAttendanceDetailPage extends StatefulWidget {
  const StudentAttendanceDetailPage({Key? key}) : super(key: key);

  @override
  State<StudentAttendanceDetailPage> createState() =>
      _StudentAttendanceDetailPageState();
}

class _StudentAttendanceDetailPageState
    extends State<StudentAttendanceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return _buildStudentAttendancePage();
  }

  Widget _buildStudentAttendancePage() {
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
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          height: 20,
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: sGreenColor,
          ),
        ),
        Text(
          'EDU-ATT-,YYYY',
          style: sWhiteTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        )
      ]),
    );
  }

  Widget _buildAttendanceDetailForm() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! instructor Field
          Text('Instructor', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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

          // ! course schedule Field
          Text('Course Schedule', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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
              hintText: 'e.x schedule',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Student Group Field
          Text('Student Group', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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
              hintText: 'e.x group',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Date Field
          Text('Date', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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
              hintText: 'e.x dd:mm:yyyy',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Status Field
          Text('Status', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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
              hintText: 'e.x present',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Growth Point Field
          Text('Growth Point', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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
              hintText: 'e.x 0',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Comment Field
          Text('Comment', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
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
          const SizedBox(height: 5),
          TextFormField(
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
              hintText: 'e.x https://xxxx',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
