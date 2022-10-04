import 'package:flutter/material.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentPaymentDetailPage extends StatefulWidget {
  const StudentPaymentDetailPage({Key? key}) : super(key: key);

  @override
  State<StudentPaymentDetailPage> createState() =>
      _StudentPaymentDetailPageState();
}

class _StudentPaymentDetailPageState extends State<StudentPaymentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return _buildPaymentDetailPage();
  }

  Widget _buildPaymentDetailPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          '  ',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  _buildHeaderLogo(),
                  const SizedBox(height: 20),
                  _buildTitle(),
                  const SizedBox(height: 10),
                  _buildCode(),
                  const SizedBox(height: 10),
                  _buildFees()
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildHeaderLogo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: sBlackColor,
          radius: 30,
          child: Image.asset('assets/images/smi-logo-red.png'),
        ),
        Text(
          'Sekolah Musik Indonesia',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff30363D),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('0062-S-PA-000190',
                        style: sWhiteTextStyle.copyWith(fontSize: 12)),
                    Text('EVANGELINE BEATRICE',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 22, fontWeight: semiBold)),
                  ]),
            )
          ],
        ));
  }

  Widget _buildCode() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff30363D),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('INVOICE',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 22, fontWeight: semiBold)),
                    Text('FEE-2209-S-PA-00193 | Sep 2022',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold)),
                    SizedBox(height: 10),
                    Text('Due : 8 Sep 2022',
                        style: sGreyTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold)),
                  ]),
            )
          ],
        ));
  }

  Widget _buildFees() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff30363D),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fees Details',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold)),
                    SizedBox(height: 20),
                    Text('Summary',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('SPP',
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                              Text('\u2022 None',
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                            ],
                          ),
                        ),
                        Text('Rp. 600.000,00',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Discount',
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                              Text('\u2022 None',
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                            ],
                          ),
                        ),
                        Text('- Rp. 100.000,00',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    Text('Payment',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('HC PIANO',
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                              Text('\u2022 Transfer',
                                  style: sGreyTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                            ],
                          ),
                        ),
                        Text('Rp. 500.000,00',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    Text('Status',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold)),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Text('Unpaid',
                          style: sGreyTextStyle.copyWith(
                              fontSize: 14, fontWeight: semiBold)),
                    ),
                    const Divider(
                      thickness: 1,
                      height: 30,
                      color: Color(0xff272C33),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Grand Total',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 20, fontWeight: semiBold)),
                        Text('Rp. 500.000,00',
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 20, fontWeight: semiBold)),
                      ],
                    ),
                  ]),
            )
          ],
        ));
  }
}
