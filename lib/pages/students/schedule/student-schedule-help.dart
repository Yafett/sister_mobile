// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentScheduleHelpPage extends StatefulWidget {
  const StudentScheduleHelpPage({Key? key}) : super(key: key);

  @override
  State<StudentScheduleHelpPage> createState() =>
      _StudentScheduleHelpPageState();
}

class _StudentScheduleHelpPageState extends State<StudentScheduleHelpPage> {
  @override
  Widget build(BuildContext context) {
    return _buildHelpPage();
  }

  Widget _buildHelpPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Help',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SizedBox(
              child: Column(
            children: [
              _buildHelp1(),
              _buildHelp2(),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildHelp1() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff8E8E8E),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xff2D333B),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text("What's Schedule",
                          style: sWhiteTextStyle.copyWith(
                              fontSize: 20, fontWeight: semiBold)),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xff8E8E8E),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      child: Text(
                          'Page, which displays the schedule for Students \n\nMake students more leisurely to know about their class and upcoming events on SMI',
                          style: sGreyTextStyle.copyWith(
                              fontSize: 14, fontWeight: semiBold)),
                    ),
                  ]),
            )
          ],
        ));
  }

  Widget _buildHelp2() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff8E8E8E),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xff2D333B),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Text("Date's Indicator",
                          style: sWhiteTextStyle.copyWith(
                              fontSize: 20, fontWeight: semiBold)),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                      color: Color(0xff8E8E8E),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10, top: 5),
                      child: Column(
                        children: [
                          Text(
                              "There's an indicator on some date, and each indicator has their meaning",
                              style: sGreyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold)),
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 5),
                            child: Column(children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: sRedColor,
                                    ),
                                    child: Center(
                                        child: Text(
                                      '7',
                                      style: sWhiteTextStyle.copyWith(
                                          fontWeight: semiBold),
                                    )),
                                  ),
                                  Text('Current Date',
                                      style: sGreyTextStyle.copyWith(
                                          fontSize: 14, fontWeight: semiBold)),
                                ],
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ));
  }
}
