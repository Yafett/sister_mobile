// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/bloc/get-attendance-bloc/get_attendance_bloc.dart';
import 'package:sister_mobile/bloc/get-enrollment-bloc/get_enrollment_bloc.dart';
import 'package:sister_mobile/bloc/get-payment-bloc/get_payment_bloc.dart';
import 'package:sister_mobile/bloc/get-point-reward-bloc/point_reward_bloc.dart';
import 'package:sister_mobile/bloc/get-profile-student-bloc/get_profile_student_bloc.dart';
import 'package:sister_mobile/bloc/get-student-schedule/student_schedule_bloc.dart';
import 'package:sister_mobile/model/Attendance-model.dart';
import 'package:sister_mobile/model/Enrollment-model.dart';
import 'package:sister_mobile/model/PointReward-model.dart';
import 'package:sister_mobile/model/ProfileStudent-model.dart';
import 'package:sister_mobile/model/Schedule-model.dart';
import 'package:sister_mobile/pages/students/history/enrollment/student-enrollment-detail.dart';
import 'package:sister_mobile/pages/students/history/enrollment/student-enrollment-history.dart';
import 'package:sister_mobile/pages/students/payment/student-payment.dart';
import 'package:sister_mobile/pages/students/profile/student-profile.dart';
import 'package:sister_mobile/pages/students/schedule/student-schedule.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:skeletons/skeletons.dart';

class StudentDetailPage extends StatefulWidget {
  String? code;
  int? index;

  StudentDetailPage({super.key, this.code, this.index});

  @override
  State<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends State<StudentDetailPage> {
  final dio = Dio();
  var cookieJar = CookieJar();

  var studentName;
  var studentCode;
  var paymentLength;

  final _profileBloc = GetProfileStudentBloc();
  final _scheduleBloc = StudentScheduleBloc();
  final _paymentBloc = GetPaymentBloc();
  final _attendanceBloc = GetAttendanceBloc();
  final _enrollmentBloc = GetEnrollmentBloc();
  final _pointBloc = PointRewardBloc();

  bool _isLoading = true;

  var studentList = [];
  var scheduleList = [];

  @override
  void initState() {
    super.initState();
    print(widget.code);
    _profileBloc.add(GetProfileList(code: widget.code));
    _scheduleBloc.add(GetScheduleList(code: widget.code));
    _paymentBloc.add(GetPaymentList(code: widget.code));
    _attendanceBloc.add(GetAttendanceList());
    _enrollmentBloc.add(GetEnrollmentList(code: widget.code));
    _pointBloc.add(GetPointRewardList());
  }

  @override
  Widget build(BuildContext context) {
    return _buildStudentDetail();
  }

  Widget _buildStudentDetail() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff0D1117),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xff0D1117),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _studentProfileSection(),
                  _studentScheduleSection(),
                  const SizedBox(height: 20),
                  _studentPaymentSection(),
                  const SizedBox(height: 20),
                  _studentHistorySection(),
                  const SizedBox(height: 20),
                  _studentRewardSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _studentProfileSection() {
    return BlocBuilder<GetProfileStudentBloc, GetProfileStudentState>(
      bloc: _profileBloc,
      builder: (context, state) {
        if (state is GetProfileLoaded) {
          Profile profile = state.profileModel;
          return SizedBox(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 5),
              Material(
                  color: sBlackColor,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    splashColor: sGreyColor,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StudentProfilePage(
                                    code: widget.code,
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff30363D),
                          ),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/lord-shrek.jpg'),
                                        fit: BoxFit.fitHeight,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        profile.data!.studentEmailId.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: sWhiteTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold)),
                                    Text(profile.data!.name.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        style: sGreyTextStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: semiBold)),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                              color: Color(0xff272C33),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'See your Kids Profile',
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: sWhiteColor,
                                  size: 20,
                                )
                              ],
                            )
                          ]),
                    ),
                  ))
            ]),
          );
        } else if (state is GetProfileLoading) {
          return Column(
            children: [
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 6,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _studentScheduleSection() {
    return BlocBuilder<StudentScheduleBloc, StudentScheduleState>(
      bloc: _scheduleBloc,
      builder: (context, state) {
        if (state is StudentScheduleLoaded) {
          Schedule schedule = state.scheduleModel;
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Schedule',
                style: sWhiteTextStyle,
              ),
              const SizedBox(height: 5),
              Material(
                color: sBlackColor,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: sGreyColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                StudentSchedulePage(codeDef: widget.code)));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff30363D),
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Upcoming Class',
                              style: sWhiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold)),
                          (schedule.message!.length == 0)
                              ? Text("There's no Schedule avaliable",
                                  style: sGreyTextStyle.copyWith(fontSize: 22))
                              : Text(
                                  '${schedule.message![0].course.toString()} - ${_setDatetimeSchedule(schedule.message![0].scheduleDate.toString())}',
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 22, fontWeight: semiBold)),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            color: Color(0xff272C33),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'See your Schedule',
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: sWhiteColor,
                                size: 20,
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              )
            ],
          ));
        } else if (state is StudentScheduleLoading) {
          return Column(
            children: [
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 6,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _studentPaymentSection() {
    return BlocBuilder<GetPaymentBloc, GetPaymentState>(
      bloc: _paymentBloc,
      builder: (context, state) {
        if (state is GetPaymentLoaded) {
          _setPaymentLength();
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  'Payment',
                  style: sWhiteTextStyle,
                ),
              ),
              Material(
                color: sBlackColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StudentPaymentPage(
                                  codeDef: widget.code,
                                )));
                  },
                  splashColor: const Color(0xff30363D),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff30363D),
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('You have',
                              style: sWhiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold)),
                          Text('${paymentLength.toString()} Unpaid Payment',
                              style: sRedTextStyle.copyWith(
                                  fontSize: 22, fontWeight: semiBold)),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            color: Color(0xff272C33),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'See your Payment',
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: sWhiteColor,
                                size: 20,
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              )
            ],
          ));
        } else if (state is GetPaymentLoading) {
          return Column(
            children: [
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 6,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _studentHistorySection() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'History',
          style: sWhiteTextStyle,
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff30363D),
              ),
              borderRadius: BorderRadius.circular(8)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            BlocBuilder<GetAttendanceBloc, GetAttendanceState>(
                bloc: _attendanceBloc,
                builder: (context, state) {
                  if (state is GetAttendanceLoaded) {
                    Attendance attendance = state.attendanceModel;
                    var dueDate =
                        DateTime.parse("${attendance.data!.date} 11:47:00");

                    String formattedDate =
                        DateFormat('EEEE, dd MMMM yyyy').format(dueDate);
                    return Material(
                      color: sBlackColor,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/student-history-attendance');
                        },
                        splashColor: sGreyColor,
                        child: SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(attendance.data!.name.toString(),
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 20, fontWeight: semiBold)),
                              Text(formattedDate.toString(),
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'See your Attendance',
                                    style: sWhiteTextStyle.copyWith(
                                        fontSize: 14, fontWeight: semiBold),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: sWhiteColor,
                                    size: 20,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("There's no history avaliable",
                            style: sGreyTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'See your Attendance',
                              style: sWhiteTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: sWhiteColor,
                              size: 20,
                            )
                          ],
                        ),
                      ],
                    );
                  }
                }),
            const Divider(
              color: Color(0xff272C33),
              height: 20,
              thickness: 1,
            ),
            BlocBuilder<GetEnrollmentBloc, GetEnrollmentState>(
              bloc: _enrollmentBloc,
              builder: (context, state) {
                if (state is GetEnrollmentLoaded) {
                  Enrollment enrollment = state.enrollModel;

                  var dueDate = DateTime.parse(
                      "${enrollment.data!.enrollmentDate} 11:47:00");

                  String formattedDate =
                      DateFormat('EEEE, dd MMMM yyyy').format(dueDate);
                  return Material(
                    color: sBlackColor,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => StudentEnrollmentHistoryPage(code: widget.code,)));
                      },
                      splashColor: sGreyColor,
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(enrollment.data!.name.toString(),
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 20, fontWeight: semiBold)),
                            Text(formattedDate.toString(),
                                style: sGreyTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold)),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'See your Enrollment',
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: sWhiteColor,
                                  size: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("There's no history avaliable",
                          style: sGreyTextStyle.copyWith(
                              fontSize: 14, fontWeight: semiBold)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'See your Enrollment',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: sWhiteColor,
                            size: 20,
                          )
                        ],
                      ),
                    ],
                  );
                }
              },
            ),
          ]),
        )
      ],
    ));
  }

  Widget _studentRewardSection() {
    return BlocBuilder<PointRewardBloc, PointRewardState>(
      bloc: _pointBloc,
      builder: (context, state) {
        if (state is PointRewardLoaded) {
          PointReward point = state.pointModel;
          return SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reward',
                style: sWhiteTextStyle,
              ),
              const SizedBox(height: 5),
              Material(
                color: sBlackColor,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Navigator.pushNamed(context, '/student-point');
                  },
                  splashColor: const Color(0xff30363D),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff30363D),
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Current Point',
                              style: sWhiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold)),
                          Row(
                            children: [
                              const Icon(Icons.favorite,
                                  color: Color(0xffD15151)),
                              const SizedBox(width: 10),
                              Text('${state.pointModel.data!.point} POINT',
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 22, fontWeight: semiBold)),
                            ],
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            color: Color(0xff272C33),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'See your reward point',
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: sWhiteColor,
                                size: 20,
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              )
            ],
          ));
        } else if (state is PointRewardLoading) {
          return Column(
            children: [
              SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 1,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 6,
                      maxLength: MediaQuery.of(context).size.width / 3,
                    )),
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  minHeight: MediaQuery.of(context).size.height / 8,
                  maxHeight: MediaQuery.of(context).size.height / 6,
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  // ! set Text
  _setPaymentLength() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        paymentLength = pref.getString('payment-length');
      });
    }
  }

  _setDatetimeSchedule(schedule) {
    var parsedDate = DateTime.parse(schedule);
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    return formattedDate;
  }
}
