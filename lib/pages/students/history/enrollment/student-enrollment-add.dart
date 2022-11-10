import 'package:flutter/material.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class StudentEnrollmentAddPage extends StatefulWidget {
  const StudentEnrollmentAddPage({super.key});

  @override
  State<StudentEnrollmentAddPage> createState() =>
      _StudentEnrollmentAddPageState();
}

class _StudentEnrollmentAddPageState extends State<StudentEnrollmentAddPage> {
  var formatList = ['FAS / Private', 'Harmony / Group', 'FoM'];
  var formatVal;

  var majorList = [
    'Drum',
    'Piano',
    'Vocal',
    'Guitar',
    'Violin',
    'Saxo',
    'Fluter',
    'MTL',
    'Bass'
  ];
  var majorVal;

  var durationList = [
    'Lite : 30 Minutes',
    'Regular : 45 Minutes',
    'Premium : 60 Minutes'
  ];
  var durationVal;

  var typeList = ['At SMI', 'Online', 'GO'];
  var typeVal;

  var courseList = [];

  @override
  Widget build(BuildContext context) {
    return _buildEnrollmentAddPage();
  }

  Widget _buildEnrollmentAddPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Course Enrollment',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                addCourseToList();
              },
              child: Icon(
                Icons.add_circle_outline_outlined,
                color: sWhiteColor,
                size: 25,
              ),
            ),
          )
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
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildForm(),
                  const SizedBox(height: 20),
                  Container(
                    height: 120 * courseList.length.toDouble(),
                    child: ListView.builder(
                      itemCount: courseList.length,
                      itemBuilder: ((context, index) {
                        var name = courseList[index]['format'].toString();
                        return _buildCourseCard(
                          index,
                          courseList[index]['duration'].toString(),
                          courseList[index]['format'].toString(),
                          courseList[index]['major'].toString(),
                          courseList[index]['type'].toString(),
                        );
                      }),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Notes : ', style: sWhiteTextStyle.copyWith(fontSize: 12)),
        Text('FOM is for 3 - 5 years old',
            style: sWhiteTextStyle.copyWith(fontSize: 12)),
        Text('FAS / Harmony is for above 5 years old ',
            style: sWhiteTextStyle.copyWith(fontSize: 12)),
      ],
    );
  }

  Widget _buildForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // ! Class Format Field
      Text('Class Format', style: fTextColorStyle),
      Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: sGreyColor,
          border: Border.all(color: sGreyColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        width: MediaQuery.of(context).size.width,
        child: DropdownButton(
          style: sWhiteTextStyle,
          dropdownColor: sGreyColor,
          underline: const SizedBox(),
          isExpanded: true,
          hint: Text('Pick your Format', style: fGreyTextStyle),
          items: formatList.map((item) {
            return DropdownMenuItem(
              value: item.toString(),
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              formatVal = newVal;
            });
          },
          value: formatVal,
        ),
      ),
      const SizedBox(height: 15),

      // ! Class Major Field
      Text('Class Major', style: fTextColorStyle),
      Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: sGreyColor,
          border: Border.all(color: sGreyColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        width: MediaQuery.of(context).size.width,
        child: DropdownButton(
          dropdownColor: sGreyColor,
          underline: const SizedBox(),
          isExpanded: true,
          hint: Text('Pick your Major', style: fGreyTextStyle),
          items: majorList.map((item) {
            return DropdownMenuItem(
              value: item.toString(),
              child: Text(
                item.toString(),
                style: sWhiteTextStyle,
              ),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              majorVal = newVal;
            });
          },
          value: majorVal,
        ),
      ),
      const SizedBox(height: 15),

      // ! Class Duration Field
      Text('Class Duration', style: fTextColorStyle),
      Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: sGreyColor,
          border: Border.all(color: sGreyColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        width: MediaQuery.of(context).size.width,
        child: DropdownButton(
          style: sWhiteTextStyle,
          dropdownColor: sGreyColor,
          underline: const SizedBox(),
          isExpanded: true,
          hint: Text('Pick your Duration', style: fGreyTextStyle),
          items: durationList.map((item) {
            return DropdownMenuItem(
              value: item.toString(),
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              durationVal = newVal;
            });
          },
          value: durationVal,
        ),
      ),
      const SizedBox(height: 15),

      // ! Class Type Field
      Text('Class Type', style: fTextColorStyle),
      Container(
        margin: const EdgeInsets.only(top: 5),
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        decoration: BoxDecoration(
          color: sGreyColor,
          border: Border.all(color: sGreyColor),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        width: MediaQuery.of(context).size.width,
        child: DropdownButton(
          style: sWhiteTextStyle,
          dropdownColor: sGreyColor,
          underline: const SizedBox(),
          isExpanded: true,
          hint: Text('Pick your Type', style: fGreyTextStyle),
          items: typeList.map((item) {
            return DropdownMenuItem(
              value: item.toString(),
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              typeVal = newVal;
            });
          },
          value: typeVal,
        ),
      ),
      const SizedBox(height: 15),
    ]);
  }

  Widget _buildCourseCard(index, major, className, duration, type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: sGreyColor),
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            color: sGreyColor,
          ),
          height: 100,
          width: 100,
          child: Icon(
            _checkIconCourse(major),
            color: sWhiteColor,
            size: 50,
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(className,
                          style: sWhiteTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      GestureDetector(
                          onTap: () {
                            removeCourseOnList(index);
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: sWhiteColor,
                          )),
                    ]),
                Row(
                  children: [
                    // ! sect 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.watch_later_outlined,
                                      size: 20,
                                      color: Color(0XFF8E8E8E),
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(duration,
                                            overflow: TextOverflow.ellipsis,
                                            style: fTextColorStyle.copyWith()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Color(0XFF8E8E8E),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Container(
                                child: SizedBox(
                                  child: Text(type,
                                      overflow: TextOverflow.ellipsis,
                                      style: fTextColorStyle.copyWith()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // ! sect 2
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.music_note_outlined,
                            size: 20,
                            color: Color(0XFF8E8E8E),
                          ),
                          Container(
                            width: 50,
                            child: Container(
                              child: SizedBox(
                                child: Text(major,
                                    overflow: TextOverflow.ellipsis,
                                    style: fTextColorStyle.copyWith()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  // ! api

  addCourseToList() {
    courseList.add({
      "format": formatVal,
      "major": majorVal,
      "duration": durationVal,
      "type": typeVal
    });

    if (mounted) {
      setState(() {
        formatVal = null;
        majorVal = null;
        durationVal = null;
        typeVal = null;
      });
    }

    print(courseList.toString());
  }

  removeCourseOnList(index) {
    setState(() {
      courseList.removeAt(index);
    });
    print(courseList);
  }

  _checkIconCourse(major) {
    if (major == 'Piano') {
      return Icons.piano;
    } else if (major == 'Vocal') {
      return Icons.mic;
    } else {
      return Icons.question_mark_sharp;
    }
  }
}
