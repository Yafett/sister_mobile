import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/pages/students/history/enrollment/student-enrollment-detail.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:skeletons/skeletons.dart';

class StudentEnrollmentHistoryPage extends StatefulWidget {
  final String? code;

  StudentEnrollmentHistoryPage({Key? key, this.code}) : super(key: key);

  @override
  State<StudentEnrollmentHistoryPage> createState() =>
      _StudentEnrollmentHistoryPageState();
}

class _StudentEnrollmentHistoryPageState
    extends State<StudentEnrollmentHistoryPage> {
  var itemList = ['', ''];

  int defaultChoiceIndex = 0;

  final dio = Dio();
  var cookieJar = CookieJar();

  bool isLoading = false;

  var enrollmentList = [];
  var rawEnrollmentList = [];

  final List<String> _choicesList = [
    'All',
    'Open',
    'Stopped',
    'Graduated',
    'Approved',
  ];

  @override
  void initState() {
    super.initState();
    _fetchStudentEnrollment(widget.code);
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
          'Enrollment History',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
        actions: const [
          // Container(
          //   margin: EdgeInsets.only(right: 20),
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: ((context) => StudentEnrollmentAddPage())));
          //     },
          //     child: Icon(
          //       Icons.add_circle_outline_outlined,
          //       color: sWhiteColor,
          //       size: 25,
          //     ),
          //   ),
          // )
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SizedBox(
              child: Column(
            children: [
              const SizedBox(height: 10),
              _buildChip(),
              const SizedBox(height: 10),
              _buildEnrollmentList(),
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
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(children: [
          Wrap(
            spacing: 4,
            children: List.generate(_choicesList.length, (index) {
              return ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                label: Text(
                  _choicesList[index],
                  style: sWhiteTextStyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(0xff444C56))),
                selected: defaultChoiceIndex == index,
                selectedColor: const Color(0xff2D333B),
                onSelected: (value) {
                  if (mounted) {
                    setState(() {
                      _filterEnrollment(_choicesList[index]);
                      defaultChoiceIndex = value ? index : defaultChoiceIndex;
                    });
                  }
                },
                backgroundColor: sBlackColor,
                elevation: 1,
                padding: EdgeInsets.symmetric(horizontal: 10),
              );
            }),
          )
        ]),
      ),
    );
  }

  Widget _buildEnrollmentList() {
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
            ...enrollmentList.map((item) {
              return _buildEnrollmentCard(item['data']);
            }).toList(),
          ],
        ),
      );
    }
  }

  Widget _buildEnrollmentCard(enrollment) {
    var dueDate = DateTime.parse("${enrollment['enrollment_date']} 11:47:00");

    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(dueDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => StudentEnrollmentDetailPage(
                      name: enrollment['name'].toString(),
                      status: enrollment['status'].toString(),
                      date: formattedDate,
                      program: enrollment['program'].toString(),
                      feeStructure: enrollment['fee_structure'].toString(),
                      className: enrollment['class_name'].toString(),
                      classFormat: enrollment['class_format'].toString(),
                      classDuration: enrollment['class_duration'].toString(),
                      classGrading: enrollment['class_grading'].toString(),
                      classType: enrollment['class_type'].toString(),
                      course: enrollment['course'].toString(),
                    ))));
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: const Color(0xff444C56))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  enrollment['name'].toString(),
                  style: sWhiteTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                Material(
                  color: sBlackColor,
                  child: InkWell(
                    splashColor: sGreyColor,
                    borderRadius: BorderRadius.circular(4),
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _chipsColor(enrollment['status'].toString()),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                          child: Text(
                        enrollment['status'].toString(),
                        style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                      )),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Ahmad Mad - DR - Drum',
              style: sGreyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              formattedDate.toString(),
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

  _chipsColor(status) {
    if (status == 'Open' || status == 'Approved') {
      return sGreenColor;
    } else {
      return sGreyColor;
    }
  }

  _fetchStudentEnrollment(codeDef) async {
    print('this is code ${codeDef}');

    isLoading = true;
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    }); 

    if (codeDef == null) {
      final getCode = await dio.get(
          "https://njajal.sekolahmusik.co.id/api/resource/Program Enrollment/");

      if (getCode.statusCode == 200) {
        for (var a = 0; a < getCode.data['data'].length; a++) {
          var code = getCode.data['data'][a]['name'];
          final request = await dio.get(
              'https://njajal.sekolahmusik.co.id/api/resource/Program Enrollment/${code}');

          if (mounted) {
            setState(() {
              enrollmentList.add(request.data);
              rawEnrollmentList.add(request.data);
            });
          }
        }
      }
    } else {
      final getCode = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Program Enrollment?filters=[["student","=","${codeDef}"]]&fields=["*"]');

      for (var a = 0; a < getCode.data['data'].length; a++) {
        final code = getCode.data['data'][a]['name'];
        final request = await dio.get(
            'https://njajal.sekolahmusik.co.id/api/resource/Program Enrollment/${code}');

        if (mounted) {
          setState(() {
            enrollmentList.add(request.data);
            rawEnrollmentList.add(request.data);
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

  _filterEnrollment(String filter) async {
    isLoading = true;

    if (mounted) {
      setState(() {
        enrollmentList.clear();
        enrollmentList = rawEnrollmentList;
      });
    }

    if (filter.toLowerCase() != 'all') {
      for (var a = 0; a < enrollmentList.length; a++) {
        var filteredList = enrollmentList
            .where((element) =>
                element['data']['status'].toString().toLowerCase() ==
                filter.toLowerCase())
            .toList();
        if (mounted) {
          setState(() {
            enrollmentList = filteredList;
          });
        }
      }
    } else {
      for (var a = 0; a < enrollmentList.length; a++) {
        var filteredList = enrollmentList
            .where((element) =>
                element['data']['status'].toString().toLowerCase() !=
                filter.toLowerCase())
            .toList();
        if (mounted) {
          setState(() {
            enrollmentList = filteredList;
          });
        }
      }
    }

    isLoading = false;
  }
}
