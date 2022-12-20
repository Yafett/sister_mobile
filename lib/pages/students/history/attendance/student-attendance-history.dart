// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_brace_in_string_interps, avoid_print

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletons/skeletons.dart';

import 'package:sister_mobile/pages/students/history/attendance/student-attendance-detail.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class StudentAttendanceHistoryPage extends StatefulWidget {
  final String? code;
  StudentAttendanceHistoryPage({Key? key, this.code}) : super(key: key);

  @override
  State<StudentAttendanceHistoryPage> createState() =>
      _StudentAttendanceHistoryPageState();
}

class _StudentAttendanceHistoryPageState
    extends State<StudentAttendanceHistoryPage> {
  var itemList = ['', ''];
  int defaultChoiceIndex = 0;

  final dio = Dio();
  var cookieJar = CookieJar();

  var rawAttendanceList = [];
  var attendanceList = [];
  var attendancePresentList = [];
  var attendanceAbsentList = [];

  var instructorName;
  var courseName;

  bool isLoading = false;

  final List<String> _choicesList = ['All', 'Absent', 'Present'];

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchStudentAttendance(widget.code);
  }

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
          'Attendance History',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildChip(),
              // _buildSearchBar(),
              const SizedBox(height: 10),
              _buildAttendanceList(),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildChip() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Wrap(
            spacing: 4,
            children: List.generate(_choicesList.length, (index) {
              return ChoiceChip(
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                label: Text(
                  _choicesList[index],
                  style: sWhiteTextStyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Color(0xff444C56))),
                selected: defaultChoiceIndex == index,
                selectedColor: const Color(0xff2D333B),
                onSelected: (value) {
                  _filterAttendance(_choicesList[index]);
                  if (mounted) {
                    setState(() {
                      defaultChoiceIndex = value ? index : defaultChoiceIndex;
                    });
                  }
                },
                backgroundColor: sBlackColor,
                elevation: 1,
                padding: const EdgeInsets.symmetric(horizontal: 10),
              );
            }),
          )
        ]),
      ),
    );
  }

  Widget _buildAttendanceList() {
    if (isLoading == true) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.rectangle,
                width: MediaQuery.of(context).size.width,
                height: 80,
              ),
            ),
            const SizedBox(height: 10),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.rectangle,
                width: MediaQuery.of(context).size.width,
                height: 80,
              ),
            ),
            const SizedBox(height: 10),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                shape: BoxShape.rectangle,
                width: MediaQuery.of(context).size.width,
                height: 80,
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            ...attendanceList.map((item) {
              return _buildAttendanceCard(item['data']);
            }).toList(),
          ],
        ),
      );
    }
  }

  Widget _buildAttendanceCard(attendance) {
    var dueDate = DateTime.parse("${attendance['date']} 11:47:00");

    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(dueDate);
    _fetchCourseStudent(attendance);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => StudentAttendanceDetailPage(
                      name: attendance['name'],
                      comment: attendance['comment'],
                      date: formattedDate,
                      growthPoint: attendance['growth_point'].toString(),
                      lesson: attendance['lesson'],
                      videoUrl: attendance['video_url'],
                      status: attendance['status'],
                    ))));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Color(0xff444C56)),
          color: const Color(0xff181B1E),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  attendance['name'].toString(),
                  style: sWhiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            Text(
              attendance['instructor'],
              style: sGreyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formattedDate,
              style: sGreyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _fetchCourseStudent(attendance) async {
    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });
    final getCode = await dio
        .get("https://sister.sekolahmusik.co.id/api/resource/Course Schedule/");

    if (getCode.statusCode == 200) {
      for (var a = 0; a < getCode.data['data'].length; a++) {
        var code = getCode.data['data'][a]['name'];
        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Course Schedule/${code}');

        if (mounted) {
          setState(() {
            instructorName = request.data['instructor_name'];
          });
        }
      }
    }
  }

  _fetchStudentAttendance(codeDef) async {
    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    if (codeDef == null) {
      final getCode = await dio.get(
          "https://sister.sekolahmusik.co.id/api/resource/Student Attendance/");

      if (getCode.statusCode == 200) {
        for (var a = 0; a < getCode.data['data'].length; a++) {
          var code = getCode.data['data'][a]['name'];

          final request = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/Student Attendance/${code}');

          if (mounted) {
            setState(() {
              rawAttendanceList.add(request.data);
              attendanceList.add(request.data);
            });
          }
        }
      }
    } else {
      print('this is code ${codeDef}');

      final getCode = await dio.get(
          'https://sister.sekolahmusik.co.id/api/resource/StudentAttendance?filters=[["student","=","${codeDef}"]]&fields=["*"]');

      for (var a = 0; a < getCode.data['data'].length; a++) {
        final code = getCode.data['data'][a]['name'];
        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Student Attendance/${code}');

        if (mounted) {
          setState(() {
            rawAttendanceList.add(request.data);
            attendanceList.add(request.data);
          });
        }
      }
    }

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  _filterAttendance(String filter) {
    isLoading = true;

    if (mounted) {
      setState(() {
        attendanceList.clear();
        attendanceList = rawAttendanceList;
      });
    }

    if (filter.toLowerCase() != 'all') {
      for (var a = 0; a < attendanceList.length; a++) {
        var filteredList = attendanceList
            .where((element) =>
                element['data']['status'].toString().toLowerCase() ==
                filter.toLowerCase())
            .toList();
        if (mounted) {
          setState(() {
            attendanceList = filteredList;
          });
        }
      }
    } else {
      for (var a = 0; a < attendanceList.length; a++) {
        var filteredList = attendanceList
            .where((element) =>
                element['data']['status'].toString().toLowerCase() !=
                filter.toLowerCase())
            .toList();
        if (mounted) {
          setState(() {
            attendanceList = filteredList;
          });
        }
      }
    }

    isLoading = false;
  }
}
