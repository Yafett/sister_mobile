// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

import '../../../shared/theme.dart';

class StudentPointPage extends StatefulWidget {
  const StudentPointPage({Key? key}) : super(key: key);

  @override
  State<StudentPointPage> createState() => _StudentPointPageState();
}

class _StudentPointPageState extends State<StudentPointPage> {
  var itemList = ['', ''];

  Barcode? result;
  QRViewController? controller;
  final qrKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return _buildPointRewardPage();
  }

  Widget _buildPointRewardPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Point Reward',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/student-point-help'),
            child: Container(
                margin: const EdgeInsets.only(right: 5),
                child: const Icon(Icons.shopify,
                    size: 30, color: Color(0xffC9D1D9))),
          ),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/student-point-help'),
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
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildPointTotal(),
                  const SizedBox(height: 40),
                  _buildBenefitTitle(),
                  const SizedBox(height: 10),
                  _buildBenefitList(),
                  const SizedBox(height: 30),
                  _buildRedeemTitle(),
                  const SizedBox(height: 10),
                  _buildRewardTile(),
                  const SizedBox(height: 30),
                 
                  // _buildClaimTitle(),
                  // const SizedBox(height: 10),
                  // _buildClaimList(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildPointTotal() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Current Point',
          style: sWhiteTextStyle.copyWith(fontSize: 14),
        ),
        Text(
          '78 POINT',
          style: sWhiteTextStyle.copyWith(fontSize: 24),
        ),
      ],
    );
  }

  Widget _buildBenefitTitle() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  'Benefit & Rewards',
                  style: sWhiteTextStyle.copyWith(
                      fontSize: 18, fontWeight: semiBold),
                ),
                Text(
                  'Bonus Merchandise and Products from SMI',
                  style: sGreyTextStyle.copyWith(fontSize: 14),
                ),
              ]),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff272C33),
                size: 20,
              ),
            ],
          ),
          const Divider(
            color: Color(0xff272C33),
            thickness: 1,
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildBenefitList() {
    return SizedBox(
        height: 160,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildRewardTile(),
            _buildRewardTile(),
          ],
        ));
  }

  Widget _buildRewardTile() {
    return Material(
      color: sBlackColor,
      child: InkWell(
        splashColor: sGreyColor,
        onTap: () {
          Navigator.pushNamed(context, '/student-point-detail');
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xff272C33),
              ),
              borderRadius: BorderRadius.circular(4)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.only(left: 5, top: 5),
              height: 100,
              width: MediaQuery.of(context).size.width / 2.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: const AssetImage('assets/images/lord-shrek.jpg'),
                    fit: BoxFit.fill),
              ),
              child: Text(
                'SMI Point',
                style: sGreyTextStyle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gold plated Guitar',
                    style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: sWhiteColor,
                        size: 15,
                      ),
                      const SizedBox(width: 5),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                text: '10000',
                                style: TextStyle(color: sRedColor)),
                            TextSpan(
                                text: ' Point',
                                style: TextStyle(color: sWhiteColor)),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildRedeemTitle() {
    return Text('Redeemable Bonuses and Vouchers', style: sGreyTextStyle);
  }

  Widget _buildClaimTitle() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Claim Reward Now',
                style: sWhiteTextStyle.copyWith(
                    fontSize: 18, fontWeight: semiBold),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xff272C33),
                size: 20,
              ),
            ],
          ),
          const Divider(
            color: Color(0xff272C33),
            thickness: 1,
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _buildClaimList() {
    return Column(
      children: <Widget>[
        ...itemList.map((item) {
          return _buildClaimCard();
        }).toList(),
      ],
    );
  }

  Widget _buildClaimCard() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: sCardColor,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            CircleAvatar(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Image.asset('assets/images/beebeegym-logo.png')),
            ),
            const SizedBox(width: 15),
            Text('Free Class at BeeBeeGyms', style: sWhiteTextStyle)
          ],
        ),
        const Divider(
          color: Color(0xff272C33),
          thickness: 1,
          height: 20,
        ),
        Text(
          'Claim Reward',
          style: sWhiteTextStyle,
        ),
      ]),
    );
  }
}
