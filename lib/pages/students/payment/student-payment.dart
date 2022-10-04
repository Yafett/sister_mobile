// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class StudentPaymentPage extends StatefulWidget {
  const StudentPaymentPage({Key? key}) : super(key: key);

  @override
  State<StudentPaymentPage> createState() => _StudentPaymentPageState();
}

class _StudentPaymentPageState extends State<StudentPaymentPage> {
  var itemList = ['', '', ''];

  @override
  Widget build(BuildContext context) {
    return _buildPaymentPage();
  }

  Widget _buildPaymentPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text('Payment',
            style: sWhiteTextStyle.copyWith(fontWeight: semiBold)),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/student-payment-help'),
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.help_outline,
                    size: 30, color: Color(0xffC9D1D9))),
          )
        ],
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SizedBox(
              child: Column(
            children: [
              _buildPaymentList(),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildPaymentList() {
    return Column(
      children: <Widget>[
        ...itemList.map((item) {
          return _buildPaymentCard();
        }).toList(),
      ],
    );
  }

  Widget _buildPaymentCard() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, '/student-payment-detail'),
              child: Container(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ICPR3113DR',
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 20, fontWeight: semiBold)),
                            Material(
                              color: sBlackColor,
                              child: InkWell(
                                splashColor: sGreyColor,
                                borderRadius: BorderRadius.circular(4),
                                onTap: () {},
                                child: Container(
                                  height: 20,
                                  width: 70,
                                  decoration: BoxDecoration(
                                    color: sGreenColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Paid',
                                    style: sWhiteTextStyle.copyWith(
                                        fontWeight: semiBold),
                                  )),
                                ),
                              ),
                            ),
                            // Container(
                            //   height: 20,
                            //   width: 5,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(12),
                            //     color: sGreenColor,
                            //   ),
                            // )
                          ],
                        ),
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
                            Text('Rp. 400.000,00',
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 26, fontWeight: semiBold)),
                            const SizedBox(height: 5),
                            Text(
                              'Drum - Premium',
                              style: sWhiteTextStyle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Due : 10 Sept 2022',
                              style: sWhiteTextStyle.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            )
          ],
        ));
  }
}
