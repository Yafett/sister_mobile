// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => StudentHomePageState();
}

class StudentHomePageState extends State<StudentHomePage> {
  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();
  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
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
              actions: const [
                Icon(Icons.qr_code_scanner, size: 30, color: Color(0xffC9D1D9)),
                SizedBox(width: 5),
                Icon(Icons.dark_mode_outlined,
                    size: 30, color: Color(0xffC9D1D9)),
                SizedBox(width: 5),
                Icon(Icons.notifications_none,
                    size: 30, color: Color(0xffC9D1D9)),
                SizedBox(width: 20),
              ],
            ),
            body: ScrollConfiguration(
              behavior: NoScrollWaves(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderProfile(),
                    _buildHeaderTitle(),
                    _buildChipStatus(),
                    const SizedBox(height: 30),
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
  }

  Widget _buildHeaderProfile() {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.red,
                    image: const DecorationImage(
                      image: AssetImage('assets/images/lord-shrek.jpg'),
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
                DigitalClock(
                    areaDecoration: const BoxDecoration(
                      color: const Color(0xff0D1117),
                    ),
                    areaWidth: 95,
                    showSecondsDigit: false,
                    hourMinuteDigitDecoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff0D1117))),
                    hourMinuteDigitTextStyle: sWhiteTextStyle.copyWith(
                      fontSize: 40,
                    )),
                Text(_getCurrentDate(), style: sWhiteTextStyle),
              ],
            ),
          ],
        ));
  }

  Widget _buildHeaderTitle() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, yafet!',
            style: sWhiteTextStyle.copyWith(fontSize: 32, fontWeight: semiBold),
          ),
          Text(
            'welcome and happy learning',
            style: sWhiteTextStyle.copyWith(fontSize: 18, fontWeight: semi),
          ),
        ],
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
          _buildChip('78 POIN', Icons.favorite),
          _buildChip('There’s no class today', Icons.star),
          _buildChip("You didn't pay yet", Icons.attach_money),
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
                  Navigator.pushNamed(context, '/student-schedule');
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
                        Text('Piano Class - 20 September 2022',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 22, fontWeight: semiBold)),
                        Text(
                          'At SMI - 08:00 AM',
                          style: sGreyTextStyle.copyWith(fontSize: 14),
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
  }

  Widget _buildPaymentSection() {
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
                        Text('Upcoming Class',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold)),
                        Text('1 Payment',
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
                    Text('You didnt have any Attendance History yet',
                        style: sGreyTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'See your History',
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
                    const Divider(
                      color: Color(0xff272C33),
                      height: 20,
                      thickness: 1,
                    ),
                    Text('You didnt have any Attendance History yet',
                        style: sGreyTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'See your History',
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
                  ]),
            )
          ],
        ));
  }

  Widget _buildRewardSection() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reward',
              style: sWhiteTextStyle,
            ),
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
                            Text('78 POIN',
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
  }

  Widget _buildSidebar() {
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
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 22.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  "Hello, John Doe",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.person_outline,
                size: 20.0, color: Colors.white),
            title: const Text("Profile"),
            textColor: Colors.white,
            dense: true,
          ),
          ListTile(
            onTap: () {},
            leading:
                const Icon(Icons.date_range, size: 20.0, color: Colors.white),
            title: const Text("Schedule"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.payment, size: 20.0, color: Colors.white),
            title: const Text("Payment"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.watch_later_outlined,
                size: 20.0, color: Colors.white),
            title: const Text("History"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.card_giftcard,
                size: 20.0, color: Colors.white),
            title: const Text("Reward Points"),
            textColor: Colors.white,
            dense: true,

            // padding: EdgeInsets.zero,
          ),
          ListTile(
            onTap: () {},
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
}
