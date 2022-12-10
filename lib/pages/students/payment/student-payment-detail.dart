// ignore_for_file: public_member_api_docs, sort_constructors_first, sized_box_for_whitespace, unused_element, unnecessary_brace_in_string_interps, prefer_typing_uninitialized_variables, must_be_immutable
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentPaymentDetailPage extends StatefulWidget {
  String? studentCode;
  String? studentName;
  String? feeName;
  DateTime dueDate;
  String? paymentDate;
  String? status;
  String? grandTotal;
  var componentsList;

  StudentPaymentDetailPage({
    Key? key,
    this.studentCode,
    this.studentName,
    this.feeName,
    required this.dueDate,
    this.paymentDate,
    this.status,
    this.grandTotal,
    this.componentsList,
  }) : super(key: key);

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
    var compList = [];

    for (var a = 0; a < widget.componentsList.length; a++) {
      compList.add(widget.componentsList[a]);
    }
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
                  _buildFees(compList)
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
                    Text('${widget.studentCode}',
                        style: sWhiteTextStyle.copyWith(fontSize: 12)),
                    Text('${widget.studentName}',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 22, fontWeight: semiBold)),
                  ]),
            )
          ],
        ));
  }

  Widget _buildCode() {
    String formattedDate = DateFormat('MMM yyyy').format(widget.dueDate);

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
                    Text('${widget.feeName} | ${formattedDate}',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold)),
                    const SizedBox(height: 10),
                    Text('Payment : 8 Sep 2022',
                        style: sGreyTextStyle.copyWith(
                            fontSize: 12, fontWeight: semiBold)),
                  ]),
            )
          ],
        ));
  }

  Widget _buildFees(List<dynamic> compList) {
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
                    const SizedBox(height: 20),
                    Text('Summary',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold)),
                    Container(
                      height: 50 * compList.length.toDouble(),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          var comp = compList[index];
                          MoneyFormatter amount =
                              MoneyFormatter(amount: comp['amount']);
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(' ${comp['fees_category'].toString()}',
                                        style: sGreyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: semiBold)),
                                    Text('\u2022 None',
                                        style: sGreyTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: semiBold)),
                                  ],
                                ),
                              ),
                              Text('Rp. ${amount.output.nonSymbol.toString()}',
                                  style: sWhiteTextStyle.copyWith(
                                      fontSize: 14, fontWeight: semiBold)),
                            ],
                          );
                        },
                        itemCount: compList.length,
                      ),
                    ),
                    Text('Status',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: semiBold)),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                      child: Material(
                        color: sBlackColor,
                        child: InkWell(
                          splashColor: sGreyColor,
                          borderRadius: BorderRadius.circular(4),
                          onTap: () {},
                          child: Container(
                            height: 20,
                            width: 70,
                            decoration: BoxDecoration(
                              color: _setChipColor(widget.status),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                                child: Text(
                              widget.status.toString(),
                              style: sWhiteTextStyle.copyWith(
                                  fontWeight: semiBold),
                            )),
                          ),
                        ),
                      ),
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
                        Text(widget.grandTotal.toString(),
                            style: sWhiteTextStyle.copyWith(
                                fontSize: 20, fontWeight: semiBold)),
                      ],
                    ),
                  ]),
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
}
