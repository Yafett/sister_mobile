// ignore_for_file: file_names

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/pages/students/payment/student-payment-detail.dart';
import 'package:sister_mobile/pages/students/student-home.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class StudentPaymentPage extends StatefulWidget {
  final String? codeDef;

  StudentPaymentPage({Key? key, this.codeDef}) : super(key: key);

  @override
  State<StudentPaymentPage> createState() => _StudentPaymentPageState();
}

class _StudentPaymentPageState extends State<StudentPaymentPage> {
  var itemList = ['', '', ''];

  var feesList = [];
  var componentsList = [];

  final studList = [];

  final dio = Dio();
  var cookieJar = CookieJar();

  @override
  void initState() {
    _fetchFeesList(widget.codeDef);
    super.initState();
  }

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
        ...feesList.map((item) {
          return _buildPaymentCard(item);
        }).toList(),
      ],
    );
  }

  Widget _buildPaymentCard(item) {
    MoneyFormatter grandTotal =
        MoneyFormatter(amount: item['data']['grand_total']);

    var dueDate = DateTime.parse("${item['data']['due_date']} 11:47:00");

    String formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(dueDate);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentPaymentDetailPage(
                              studentCode: item['data']['student'],
                              studentName: item['data']['student_name'],
                              feeName: item['data']['name'],
                              dueDate: dueDate,
                              grandTotal: grandTotal.output.nonSymbol,
                              status: item['data']['status'],
                              componentsList: item['data']['components'],
                            )));
              },
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
                            Text('${item['data']['name'].toString()}',
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
                                    color:
                                        _setChipColor(item['data']['status']),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                      child: Text(
                                    '${item['data']['status']}',
                                    style: sWhiteTextStyle.copyWith(
                                        fontWeight: semiBold),
                                  )),
                                ),
                              ),
                            ),
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
                            Text('Rp. ${grandTotal.output.nonSymbol}',
                                style: sWhiteTextStyle.copyWith(
                                    fontSize: 26, fontWeight: semiBold)),
                            const SizedBox(height: 5),
                            Text(
                              '${item['data']['company']}',
                              style: sWhiteTextStyle.copyWith(fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Due : ${formattedDate.toString()}',
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

  _setChipColor(item) {
    if (item == 'Unpaid') {
      return sOrangeColor;
    } else if (item == 'Paid') {
      return sGreenColor;
    } else if (item == 'Overdue') {
      return sRedColor;
    } else {
      return sGreyColor;
    }
  }

  _fetchFeesList(codeDef) async {
    final dio = Dio();
    var cookieJar = CookieJar();
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
      // ! guardian

      print('guardian');

      final getCode =
          await dio.get("https://njajal.sekolahmusik.co.id/api/resource/Fees");

      if (getCode.statusCode == 200) {
        for (var a = 0; a < getCode.data['data'].length; a++) {
          var code = getCode.data['data'][a]['name'];
          final request = await dio.get(
              'https://njajal.sekolahmusik.co.id/api/resource/Fees/${code}');

          if (mounted) {
            setState(() => feesList.add(request.data));
          }
        }

        for (var a = 0; a < feesList.length; a++) {
          componentsList.add(feesList[a]['data']['components']);
        }
      }
    } else {
      print('student');

      final getCode = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Fees?filters=[["student","=","${codeDef}"]]&fields=["*"]');

      for (var a = 0; a < getCode.data['data'].length; a++) {
        studList.add(getCode.data['data'][a]['name']);
      }

      for (var a = 0; a < studList.length; a++) {
        var code = studList[a];
        final request = await dio
            .get('https://njajal.sekolahmusik.co.id/api/resource/Fees/${code}');

        if (mounted) {
          setState(() => feesList.add(request.data));
        }
      }

      for (var a = 0; a < feesList.length; a++) {
        componentsList.add(feesList[a]['data']['components']);
      }
    }
  }
}
