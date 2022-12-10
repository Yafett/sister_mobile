// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names, unnecessary_const, prefer_const_constructors, unused_local_variable, unused_field, prefer_typing_uninitialized_variables

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:sister_mobile/bloc/get-enrollment-bloc/get_enrollment_bloc.dart';
import 'package:sister_mobile/bloc/get-point-reward-bloc/point_reward_bloc.dart';
import 'package:sister_mobile/bloc/get-student-schedule/student_schedule_bloc.dart';
import 'package:sister_mobile/model/Enrollment-model.dart';
import 'package:sister_mobile/pages/auth/splash-page.dart';
import 'package:sister_mobile/pages/students/payment/student-payment-history.dart';
import 'package:sister_mobile/pages/auth/student-profile.dart';
import 'package:sister_mobile/resources/profile-provider.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../../bloc/get-attendance-bloc/get_attendance_bloc.dart';
import '../../bloc/get-payment-bloc/get_payment_bloc.dart';
import '../../bloc/get-profile-student-bloc/get_profile_student_bloc.dart';
import '../../model/Attendance-model.dart';
import '../../model/PointReward-model.dart';
import '../../model/ProfileStudent-model.dart';
import '../../model/Schedule-model.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => StudentHomePageState();
}

class StudentHomePageState extends State<StudentHomePage> {
  var cookieJar = CookieJar();
  var dio = Dio();
  bool isOpened = false;
  var length;
  var pass;
  var unpaidPaymentLength;
  var paymentLength;
  var scheduleLength;
  var user;
  var pointTotal;
  String _scanBarcode = 'Unknown';

  final _attendanceBloc = GetAttendanceBloc();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();
  final _enrollmentBloc = GetEnrollmentBloc();
  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final _paymentBloc = GetPaymentBloc();
  final _pointBloc = PointRewardBloc();
  final _profileAuth = ProfileProvider();
  final _profileBloc = GetProfileStudentBloc();
  final _scheduleBloc = StudentScheduleBloc();

  @override
  void initState() {
    super.initState();
    _pointBloc.add(GetPointRewardList());
    _profileBloc.add(GetProfileList());
    _scheduleBloc.add(GetScheduleList());
    _paymentBloc.add(GetPaymentList());
    _attendanceBloc.add(GetAttendanceList());
    _enrollmentBloc.add(GetEnrollmentList());
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    return BlocConsumer<GetProfileStudentBloc, GetProfileStudentState>(
      bloc: _profileBloc,
      listener: (context, state) {
        if (state is GetProfileLoaded) {}
      },
      builder: (context, state) {
        if (state is GetProfileLoaded) {
          Profile profile = state.profileModel;
          return SideMenu(
            key: _endSideMenuKey,
            inverse: true, // end side menu
            background: Colors.green[700],
            type: SideMenuType.slideNRotate,
            menu: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: _buildSidebar(profile.data),
            ),
            maxMenuWidth: 250,
            onChange: (_isOpened) {
              if (mounted) {
                setState(() => isOpened = _isOpened);
              }
            },
            child: SideMenu(
              maxMenuWidth: 250,
              radius: BorderRadius.circular(12),
              background: const Color.fromARGB(255, 41, 41, 41),
              key: _sideMenuKey,
              menu: _buildSidebar(profile.data),
              type: SideMenuType.slideNRotate,
              onChange: (_isOpened) {
                if (mounted) {
                  setState(() => isOpened = _isOpened);
                }
              },
              child: IgnorePointer(
                ignoring: isOpened,
                child: Scaffold(
                  backgroundColor: const Color(0xff0D1117),
                  appBar: AppBar(
                    backgroundColor: const Color(0xff0D1117),
                    centerTitle: true,
                    leading: IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => _toggleMenu(),
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () async {
                          barcodeScan();
                        },
                        child: Icon(Icons.qr_code_scanner,
                            size: 30, color: Color(0xffC9D1D9)),
                      ),
                      SizedBox(width: 20),
                      // Icon(Icons.dark_mode_outlined,
                      //     size: 30, color: Color(0xffC9D1D9)),
                      // SizedBox(width: 5),
                      // Icon(Icons.notifications_none,
                      //     size: 30, color: Color(0xffC9D1D9)),
                      // SizedBox(width: 20),
                    ],
                  ),
                  body: ScrollConfiguration(
                    behavior: NoScrollWaves(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeaderSection(state.profileModel.data),
                          _buildScheduleSection(),
                          const SizedBox(height: 30),
                          _buildPaymentSection(),
                          const SizedBox(height: 30),
                          _buildHistorySection(),
                          const SizedBox(height: 30),
                          _buildRewardSection(),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return _buildSkeleton();
        }
      },
    );
  }

  Widget _buildHeaderSection(profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeaderProfile(profile),
        _buildHeaderTitle(profile),
        _buildChipStatus(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildSkeleton() {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    shape: BoxShape.rectangle,
                    width: 80,
                    height: 80,
                  ),
                ),
                SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                      lines: 2,
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
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          randomLength: true,
                          maxLength: 100,
                          minLength: 60,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          randomLength: true,
                          maxLength: 100,
                          minLength: 60,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: SkeletonLine(
                        style: SkeletonLineStyle(
                          randomLength: true,
                          maxLength: 100,
                          minLength: 60,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderProfile(profile) {
    final image;
    if (profile.image.toString()[0] == '/') {
      image = 'https://sister.sekolahmusik.co.id${profile.image}';
    } else {
      image = profile.image.toString();
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/student-profile');
      },
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // Navigator.pushNamed(context, '/student-profile');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentProfilePage(
                              code: profile.name.toString())));
                },
                child: (profile.image == null)
                    ? Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: const DecorationImage(
                              image: AssetImage('assets/images/lord-shrek.jpg'),
                              fit: BoxFit.fitHeight,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      )
                    : Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.fitHeight,
                            ),
                            borderRadius: BorderRadius.circular(8)),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DigitalClock(
                    areaHeight: 0,
                    areaDecoration: const BoxDecoration(
                      color: const Color(0xff0D1117),
                    ),
                    hourMinuteDigitDecoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff0D1117))),
                    areaWidth: 0,
                    digitAnimationStyle: Curves.elasticOut,
                    showSecondsDigit: false,
                    hourMinuteDigitTextStyle: const TextStyle(
                      color: Color(0xff0D1117),
                      fontSize: 0,
                    ),
                  ),

                  // ! real clock
                  Container(
                    // margin: EdgeInsets.only(right: 10),
                    child: DigitalClock(
                        areaDecoration: const BoxDecoration(
                          color: const Color(0xff0D1117),
                        ),
                        // areaWidth: 95,
                        areaWidth: 115,
                        showSecondsDigit: false,
                        hourMinuteDigitDecoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff0D1117))),
                        hourMinuteDigitTextStyle: sWhiteTextStyle.copyWith(
                          fontSize: 40,
                        )),
                  ),
                  Text(_getCurrentDate(), style: sWhiteTextStyle),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildHeaderTitle(profile) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StudentProfilePage(code: profile.name.toString())));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${profile.firstName.toString().toLowerCase()} !',
              style:
                  sWhiteTextStyle.copyWith(fontSize: 32, fontWeight: semiBold),
            ),
            Text(
              'welcome and happy learning',
              style: sWhiteTextStyle.copyWith(fontSize: 18, fontWeight: semi),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipStatus() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          BlocBuilder<PointRewardBloc, PointRewardState>(
            bloc: _pointBloc,
            builder: (context, state) {
              if (state is PointRewardLoaded) {
                PointReward point = state.pointModel;
                return GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/student-point'),
                    child: _buildChip(
                        '${pointTotal.toString()} POINT', Icons.favorite));
              } else {
                return Container();
              }
            },
          ),
          (scheduleLength.toString() == 'null')
              ? _buildChip('No Class', Icons.star)
              : _buildChip('${scheduleLength.toString()} Class', Icons.star),
          (paymentLength.toString() == 'null')
              ? _buildChip("No Payment History", Icons.attach_money)
              : GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentPaymentPage())),
                  child: _buildChip("${paymentLength.toString()} Payment Total",
                      Icons.attach_money),
                ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: Chip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Color(0xff30363D))),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        backgroundColor: const Color(0xff272C33),
        avatar: Icon(icon, color: sWhiteColor, size: 15),
        deleteIcon: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: sWhiteColor,
        ),
        label: Text(
          label,
          style: sWhiteTextStyle.copyWith(fontSize: 16),
        ),
        deleteButtonTooltipMessage: 'erase',
        onDeleted: () {},
      ),
    );
  }

  Widget _buildScheduleSection() {
    return BlocBuilder<StudentScheduleBloc, StudentScheduleState>(
      bloc: _scheduleBloc,
      builder: (context, state) {
        if (state is StudentScheduleLoaded) {
          Schedule schedule = state.scheduleModel;
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        if (schedule.message!.length != 0) {
                          Navigator.pushNamed(context, '/student-schedule');
                        }
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
                                      style:
                                          sGreyTextStyle.copyWith(fontSize: 22))
                                  : Text('${_getDate(schedule)}',
                                      style: sWhiteTextStyle.copyWith(
                                          fontSize: 22, fontWeight: semiBold)),
                              (schedule.message!.length == 0)
                                  ? SizedBox()
                                  : Text(
                                      '${schedule.message![0].fromTime.toString()} - ${_setDatetimeSchedule(schedule.message![0].scheduleDate.toString())}',
                                      style: sGreyTextStyle.copyWith(
                                          fontSize: 14, fontWeight: semiBold)),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xff272C33),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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

  Widget _buildPaymentSection() {
    return BlocBuilder<GetPaymentBloc, GetPaymentState>(
      bloc: _paymentBloc,
      builder: (context, state) {
        if (state is GetPaymentLoaded) {
          _setPaymentLength();
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        Navigator.pushNamed(context, '/student-payment');
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
                              Text(
                                  '${unpaidPaymentLength.toString()} Unpaid Payment',
                                  style: sRedTextStyle.copyWith(
                                      fontSize: 22, fontWeight: semiBold)),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xff272C33),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      onTap: () {},
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
                              Text("There's no Payment available",
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 22, fontWeight: semiBold)),
                              const Divider(
                                height: 20,
                                thickness: 1,
                                color: Color(0xff272C33),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
        }
      },
    );
  }

  Widget _buildHistorySection() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'History',
              style: sWhiteTextStyle,
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff30363D),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<GetAttendanceBloc, GetAttendanceState>(
                        bloc: _attendanceBloc,
                        builder: (context, state) {
                          if (state is GetAttendanceLoaded) {
                            Attendance attendance = state.attendanceModel;
                            var dueDate = DateTime.parse(
                                "${attendance.data!.date} 11:47:00");

                            String formattedDate =
                                DateFormat('EEEE, dd MMMM yyyy')
                                    .format(dueDate);
                            return Material(
                              color: sBlackColor,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {
                                  Navigator.pushNamed(
                                      context, '/student-history-attendance');
                                },
                                splashColor: sGreyColor,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(attendance.data!.name.toString(),
                                          style: sWhiteTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: semiBold)),
                                      Text(formattedDate.toString(),
                                          style: sGreyTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: semiBold)),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'See your Attendance',
                                            style: sWhiteTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold),
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
                            return Material(
                              color: sBlackColor,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () async {},
                                splashColor: sGreyColor,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("There's no Attendance avaliable",
                                          style: sGreyTextStyle.copyWith(
                                              fontSize: 20,
                                              fontWeight: semiBold)),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'See your Attendance',
                                            style: sWhiteTextStyle.copyWith(
                                                fontSize: 14,
                                                fontWeight: semiBold),
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
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, '/student-history-enrollment');
                              },
                              splashColor: sGreyColor,
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(enrollment.data!.name.toString(),
                                        style: sWhiteTextStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: semiBold)),
                                    Text(formattedDate.toString(),
                                        style: sGreyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: semiBold)),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'See your Enrollment',
                                          style: sWhiteTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: semiBold),
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
                          return Material(
                            color: sBlackColor,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () async {
                                Navigator.pushNamed(
                                    context, '/student-history-enrollment');
                              },
                              splashColor: sGreyColor,
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("There's no Enrollment available",
                                        style: sGreyTextStyle.copyWith(
                                            fontSize: 20,
                                            fontWeight: semiBold)),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'See your Enrollment',
                                          style: sWhiteTextStyle.copyWith(
                                              fontSize: 14,
                                              fontWeight: semiBold),
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
                        }
                      },
                    ),
                  ]),
            )
          ],
        ));
  }

  Widget _buildRewardSection() {
    return BlocBuilder<PointRewardBloc, PointRewardState>(
      bloc: _pointBloc,
      builder: (context, state) {
        if (state is PointRewardLoaded) {
          _setPointTotal();
          PointReward point = state.pointModel;
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  Text('${pointTotal.toString()} POINT',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildSidebar(profile) {
    final image;
    if (profile.image.toString()[0] == '/') {
      image = 'https://sister.sekolahmusik.co.id${profile.image}';
    } else {
      image = profile.image.toString();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (profile.image == null)
                    ? CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22.0,
                        backgroundImage:
                            AssetImage('assets/images/lord-shrek.jpg'),
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 22.0,
                        backgroundImage: NetworkImage(image),
                      ),
                SizedBox(height: 16.0),
                Text(
                  'Hello, ${profile.firstName.toString().toLowerCase()}',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StudentProfilePage(
                            code: profile.name,
                          )));
            },
            leading: const Icon(Icons.person_outline,
                size: 20.0, color: Colors.white),
            title: const Text("Profile"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/student-schedule');
            },
            leading:
                const Icon(Icons.date_range, size: 20.0, color: Colors.white),
            title: const Text("Schedule"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/student-payment');
            },
            leading: const Icon(Icons.payment, size: 20.0, color: Colors.white),
            title: const Text("Payment"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          // ListTile(
          //   onTap: () {},
          //   leading: const Icon(Icons.watch_later_outlined,
          //       size: 20.0, color: Colors.white),
          //   title: const Text("History"),
          //   textColor: Colors.white,
          //   dense: true,

          //   // padding: EdgeInsets.zero,
          // ),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, '/student-point');
            },
            leading: const Icon(Icons.card_giftcard,
                size: 20.0, color: Colors.white),
            title: const Text("Reward Points"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () async {
              showAlertDialog(context);
            },
            leading:
                const Icon(Icons.exit_to_app, size: 20.0, color: Colors.white),
            title: const Text("Logout"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  _toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  _getCurrentDate() {
    var date = DateTime.now().toString();

    var dateParse = DateTime.parse(date);

    var formattedRawDate =
        "${dateParse.day}-${dateParse.month}-${dateParse.year}";

    var formattedDate = DateFormat("EEE, d MMMM").format(DateTime.now());

    return formattedDate.toString();
  }

  _getDate(schedule) {
    var listDate = [];

    for (var a = 0; a < schedule.message.length; a++) {
      var replacedFrom =
          schedule.message[a].scheduleDate.toString().replaceAll('-', '');
      DateTime now = DateTime.now();
      String dateFromT = replacedFrom.substring(0, 8);
      DateTime fromDateTime = DateTime.parse(dateFromT);

      if (fromDateTime.isAfter(now) == true) {
        var parsedDate = DateTime.parse(schedule.message[a].scheduleDate);
        String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
        listDate.add(schedule.message[a].course.toString() +
            ' ' +
            formattedDate.toString());
      }
    }

    return listDate[0].toString();
  }

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Icon(
            Icons.directions_run_outlined,
            size: 50,
          ),
          const SizedBox(height: 15),
          Text("Are you sure want to logout?"),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context); 
              },
              child: Container(
                width: 80,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                    child: Text(
                  'Nah',
                  style: sWhiteTextStyle.copyWith(
                      fontWeight: semiBold, color: Colors.white),
                )),
              ),
            ),
            GestureDetector(
              onTap: () async {
                await dio
                    .get('https://sister.sekolahmusik.co.id/api/method/logout');
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => SplashPage()),
                    (route) => false);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                    child: Text(
                  'Sure',
                  style: sRedTextStyle.copyWith(
                    fontWeight: semiBold,
                  ),
                )),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // ! set Text
  _setPaymentLength() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        unpaidPaymentLength = pref.getString('payment-length');
        paymentLength = pref.getString('payment-total');
        scheduleLength = pref.getString('schedule-length');
      });
    }
  }

  _setPointTotal() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (mounted) {
      setState(() {
        pointTotal = pref.getString('point-length');
      });
    }
  }

  _setCourseSchedule(schedule) {
    if (schedule == 'DR - Drum') {
      return 'Drum Class';
    } else if (schedule == 'AG - Acoustic Guitar') {
      return 'Acoustic Guitar Class';
    } else if (schedule == 'CE - Cello') {
      return 'Cello Class';
    } else if (schedule == 'FL - Flute') {
      return 'Flute Class';
    } else if (schedule == 'SA - Saxophone') {
      return 'Saxophone Class';
    } else if (schedule == 'VI - Violin') {
      return 'Violin Class';
    } else if (schedule == 'BA - Bass') {
      return 'Bass Class';
    } else if (schedule == 'EG - Electric Guitar') {
      return 'Electric Guitar Class';
    } else if (schedule == 'VO - Vocal') {
      return 'Vocal Class';
    } else if (schedule == 'MM - Multi Mayor') {
      return 'Multi Mayor Class';
    } else if (schedule == 'PI - Piano') {
      return 'Piano Class';
    }
  }

  _setDatetimeSchedule(schedule) {
    var parsedDate = DateTime.parse(schedule);
    String formattedDate = DateFormat('dd MMMM yyyy').format(parsedDate);
    return formattedDate;
  }
}
