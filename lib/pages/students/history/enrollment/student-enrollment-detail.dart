// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class StudentEnrollmentDetailPage extends StatefulWidget {
  String? name;
  String? date;
  String? status;
  String? program;
  String? feeStructure;
  String? className;
  String? classFormat;
  String? classGrading;
  String? classType;
  String? classDuration;
  String? course;

  StudentEnrollmentDetailPage({
    Key? key,
    this.name,
    this.date,
    this.status,
    this.program,
    this.feeStructure,
    this.className,
    this.classFormat,
    this.classGrading,
    this.classType,
    this.classDuration,
    this.course,
  }) : super(key: key);

  @override
  State<StudentEnrollmentDetailPage> createState() =>
      _StudentEnrollmentDetailPageState();
}

class _StudentEnrollmentDetailPageState
    extends State<StudentEnrollmentDetailPage> {
  final _programController = TextEditingController();
  final _feeStructureController = TextEditingController();
  final _classNameController = TextEditingController();
  final _classFormatController = TextEditingController();
  final _classGradingController = TextEditingController();
  final _classTypeController = TextEditingController();
  final _classDurationController = TextEditingController();
  final _courseController = TextEditingController();

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
          'Enrollment Detail',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
        actions: [
          PopupMenuButton(
            icon: const Icon(
                Icons.more_vert), //don't specify icon if you want 3 dot menu
            color: sGreyColor,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete",
                  style: TextStyle(color: sWhiteColor),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Text(
                  "Graduate",
                  style: TextStyle(color: sWhiteColor),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Text(
                  "Cancel",
                  style: TextStyle(color: sWhiteColor),
                ),
              ),
            ],
            onSelected: (item) => {print(item)},
          ),
        ],
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
          Text('start : ' + widget.date.toString(), style: fTextColorStyle),
        ],
      ),
    );
  }

  Widget _buildAttendanceDetailForm() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! Program Field
          Text('Program', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _programController,
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

          // ! Class Name Field
          Text('Class Name', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _classNameController,
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

          // ! Fees Structure Field
          Text('Fees Structure', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _feeStructureController,
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

          // ! Class Format Field
          Text('Class Format', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _classFormatController,
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

          // ! Class Grading Field
          Text('Class Grading', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _classGradingController,
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

          // ! Class Type Field
          Text('Class Type', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _classTypeController,
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

          // ! Class Duration Field
          Text('Class Duration', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _classDurationController,
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

          // ! Course Field
          Text('Course', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            readOnly: true,
            style: sGreyTextStyle,
            controller: _courseController,
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
        ],
      ),
    );
  }

  _setValue() {
    _programController.text = widget.program.toString();
    _classNameController.text = widget.className.toString();
    _feeStructureController.text = widget.feeStructure.toString();
    _classFormatController.text = widget.classFormat.toString();
    _classGradingController.text = widget.classGrading.toString();
    _classTypeController.text = widget.classType.toString();
    _classDurationController.text = widget.classDuration.toString();
    _courseController.text = widget.course.toString();
  }
}
