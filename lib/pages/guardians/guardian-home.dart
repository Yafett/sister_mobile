// ignore_for_file: no_leading_underscores_for_local_identifiers, file_names, unnecessary_const, prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:sister_mobile/bloc/get-profile-guardian-bloc/get_profile_guardian_bloc.dart';
import 'package:sister_mobile/bloc/get-profile-user-bloc/get_profile_user_bloc.dart';
import 'package:sister_mobile/model/ProfileGuardian-model.dart';
import 'package:sister_mobile/pages/guardians/student-details.dart';
import 'package:sister_mobile/pages/auth/splash-page.dart';
import 'package:sister_mobile/pages/students/profile/student-profile.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:intl/intl.dart';
import 'package:skeletons/skeletons.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

import '../../bloc/get-profile-student-bloc/get_profile_student_bloc.dart';
import '../../resources/data-provider.dart';

class GuardianHomePage extends StatefulWidget {
  const GuardianHomePage({Key? key}) : super(key: key);

  @override
  State<GuardianHomePage> createState() => GuardianHomePageState();
}

class GuardianHomePageState extends State<GuardianHomePage> {
  bool isOpened = false;
  String _scanBarcode = 'Unknown';

  var studentList = [];
  var paymentList = [];
  final rawPaymentList = [];
  var scheduleList = [];
  List lists = [
    ["list1"],
    ["list2"]
  ];

  bool _isLoading = true;

  var paymentLength = '';

  var profileLength;

  var dio = Dio();
  var cookieJar = CookieJar();

  var listPicture = [];

  final _profileBloc = GetProfileStudentBloc();
  final _userBloc = GetProfileUserBloc();
  final _guardianBloc = GetProfileGuardianBloc();

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  final dataProvider = DataProvider();

  @override
  void initState() {
    _profileBloc.add(GetProfileList());
    _userBloc.add(GetProfileUserList());
    _guardianBloc.add(GetProfileGuardianList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    return SideMenu(
      key: _endSideMenuKey,
      inverse: true, // end side menu
      background: Colors.green[700],
      type: SideMenuType.slideNRotate,
      menu: Padding(
        padding: const EdgeInsets.only(left: 25.0),
        child: _buildSidebar(),
      ),
      maxMenuWidth: 250,
      onChange: (_isOpened) {
        setState(() => isOpened = _isOpened);
      },
      child: SideMenu(
        maxMenuWidth: 250,
        radius: BorderRadius.circular(12),
        background: const Color.fromARGB(255, 41, 41, 41),
        key: _sideMenuKey,
        menu: _buildSidebar(),
        type: SideMenuType.slideNRotate,
        onChange: (_isOpened) {
          setState(() => isOpened = _isOpened);
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
              ],
            ),
            body: ScrollConfiguration(
              behavior: NoScrollWaves(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headerSection(),
                    BlocConsumer<GetProfileGuardianBloc,
                        GetProfileGuardianState>(
                      bloc: _guardianBloc,
                      listener: (context, state) {
                        if (state is GetProfileGuardianLoaded) {
                          ProfileGuardian guardian = state.guardianModel;
                          List<Students>? students = guardian.data?.students;

                          _fetchStudentProfile(students);
                        }
                      },
                      builder: (context, state) {
                        if (state is GetProfileGuardianLoaded) {
                          ProfileGuardian guardian = state.guardianModel;
                          List<Students>? students = guardian.data?.students;
                          final student = studentList;
                          return (_isLoading == true)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    children: [
                                      SkeletonParagraph(
                                        style: SkeletonParagraphStyle(
                                            lines: 1,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            spacing: 6,
                                            lineStyle: SkeletonLineStyle(
                                              randomLength: true,
                                              height: 10,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              minLength: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              maxLength: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                            )),
                                      ),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: double.infinity,
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.4,
                                        margin: EdgeInsets.only(
                                            bottom: 20, top: 15),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Student',
                                                style: sWhiteTextStyle.copyWith(
                                                    fontSize: 20,
                                                    fontWeight: semiBold)),
                                            const SizedBox(height: 10),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: studentList.length,
                                              primary: false,
                                              itemBuilder: (context, index) {
                                                return _buildStudentProfileCard(
                                                    student, index);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerSection() {
    return BlocConsumer<GetProfileGuardianBloc, GetProfileGuardianState>(
      bloc: _guardianBloc,
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetProfileGuardianLoaded) {
          ProfileGuardian profile = state.guardianModel;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderProfile(profile.data),
              _buildHeaderTitle(profile.data),
            ],
          );
        } else if (state is GetProfileGuardianLoading) {
          return _buildSkeleton();
        } else {
          return Container();
        }
      },
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudentProfilePage(
                      code: profile.name,
                      guardian: true,
                    )));
      },
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentProfilePage(
                                code: profile.name,
                                guardian: true,
                              )));
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
                              fit: BoxFit.cover,
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

  Widget _buildStudentProfileCard(students, index) {
    final image;
    if (studentList[index]['data']['image'].toString()[0] == '/') {
      image =
          'https://sister.sekolahmusik.co.id${studentList[index]['data']['image']}';
    } else {
      image = studentList[index]['data']['image'].toString();
    }

    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        builder: (context) => StudentDetailPage(
                              code: studentList[index]['data']['name'],
                              index: index,
                            )));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
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
                          (studentList[index]['data']['image'] != null)
                              ? Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: NetworkImage(image),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                )
                              : Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/lord-shrek.jpg'),
                                        fit: BoxFit.fitHeight,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                          const SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  studentList[index]['data']['first_name']
                                      .toString()
                                      .toLowerCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 16, fontWeight: semiBold)),
                              Text(
                                  studentList[index]['data']['name']
                                      .toString()
                                      .toLowerCase(),
                                  overflow: TextOverflow.ellipsis,
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 16, fontWeight: semiBold)),
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
  }

  Widget _buildHeaderTitle(profile) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/student-profile');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${profile.guardianName.toString().toLowerCase()}!',
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

  Widget _buildSidebar() {
    return BlocBuilder<GetProfileGuardianBloc, GetProfileGuardianState>(
      bloc: _guardianBloc,
      builder: (context, state) {
        if (state is GetProfileGuardianLoaded) {
          ProfileGuardian guardian = state.guardianModel;
          final image;
          if (guardian.data!.image.toString()[0] == '/') {
            image = 'https://sister.sekolahmusik.co.id${guardian.data!.image}';
          } else {
            image = guardian.data!.image.toString();
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
                      (guardian.data!.image == null)
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
                        "Hello, ${guardian.data!.guardianName.toString().toLowerCase()}!",
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
                                  code: guardian.data!.name,
                                  guardian: true,
                                )));
                  },
                  leading: const Icon(Icons.person_outline,
                      size: 20.0, color: Colors.white),
                  title: const Text("Profile"),
                  textColor: Colors.white,
                  dense: true,
                ),
                ListTile(
                  onTap: () async {
                    showAlertDialog(context);
                  },
                  leading: const Icon(Icons.exit_to_app,
                      size: 20.0, color: Colors.white),
                  title: const Text("Logout"),
                  textColor: Colors.white,
                  dense: true,

                  // padding: EdgeInsets.zero,
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
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

  _fetchStudentProfile(students) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    print('studets : ' + students[0].student.toString());

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
      'usr': user,
      'pwd': pass,
    });

    for (var a = 0; a < students.length; a++) {
      final request = await dio.get(
          'https://sister.sekolahmusik.co.id/api/resource/Student/' +
              students![a].student.toString());

      if (mounted) {
        setState(() {
          studentList.add(request.data);
          profileLength = students.length;
        });
      }
    }

    _isLoading = false;
  }
}
