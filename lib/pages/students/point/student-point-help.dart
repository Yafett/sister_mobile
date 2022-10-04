// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentPointHelpPage extends StatefulWidget {
  const StudentPointHelpPage({Key? key}) : super(key: key);

  @override
  State<StudentPointHelpPage> createState() => _StudentPointHelpPageState();
}

class _StudentPointHelpPageState extends State<StudentPointHelpPage> {
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
                      child: Text("What's Point Reward",
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
                          'If you have Point,\nyou can exchange it here\n\nYou can exchange it for BeeBeeGym and SMI products, or Discount Voucher for your Class',
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
                      child: Text("How to get Point",
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('You can get your point, by doing some things',
                              style: sGreyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold)),
                          Text('\u2022 Paying Class Payment',
                              style: sGreyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold)),
                          Text('\u2022 Absent in Class',
                              style: sGreyTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold)),
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ));
  }
}
