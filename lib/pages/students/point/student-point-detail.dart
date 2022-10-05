// ignore_for_file: file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
 
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class StudentPointDetailPage extends StatefulWidget {
  const StudentPointDetailPage({Key? key}) : super(key: key);

  @override
  State<StudentPointDetailPage> createState() => _StudentPointDetailPageState();
}

class _StudentPointDetailPageState extends State<StudentPointDetailPage> {
  @override
  Widget build(BuildContext context) {
    return _buildDetailPage();
  }

  Widget _buildDetailPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: sBlackColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          decoration:
              BoxDecoration(border: Border(top: BorderSide(color: sGreyColor))),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('100000 Point',
                style: sWhiteTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold)),
            Material(
              color: sBlackColor,
              child: InkWell(
                splashColor: sGreyColor,
                borderRadius: BorderRadius.circular(4),
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 70,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 139, 0, 0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                      child: Text(
                    'Exchange',
                    style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                  )),
                ),
              ),
            ),
          ]),
        ),
      ),
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Product Detail',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
            child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailImage(),
              _buildDetailTitle(),
              const SizedBox(height: 10),
              _buildDetailPrivacy(),
              const SizedBox(height: 30),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildDetailImage() {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/lord-shrek.jpg'),
              fit: BoxFit.cover)),
    );
  }

  Widget _buildDetailTitle() {
    return Container(
      decoration: BoxDecoration(
          color: sCardColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(
                4,
              ))),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gold plated Guitar',
            style: sWhiteTextStyle.copyWith(fontSize: 30, fontWeight: semiBold),
          ),
          Text(
            'Until 30 May 2022',
            style: sGreyTextStyle.copyWith(fontSize: 15, fontWeight: semiBold),
          ),
          const Divider(
            height: 20,
            thickness: 1,
            color: Color(0xff272C33),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                            text: '10000', style: TextStyle(color: sRedColor)),
                        TextSpan(
                            text: ' Point',
                            style: TextStyle(color: sWhiteColor)),
                      ],
                    ),
                  )
                ],
              ),
              Text(
                'Stock > 10',
                style: sWhiteTextStyle.copyWith(
                    fontSize: 14, fontWeight: semiBold),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDetailPrivacy() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: sCardColor, borderRadius: BorderRadius.circular(4)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Privacy & Policy',
          style: sWhiteTextStyle.copyWith(fontSize: 18, fontWeight: semiBold),
        ),
        const SizedBox(height: 10),
        Text(
          'How to exchange your Point:',
          style: sGreyTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. Exchange your Point by Click "Exchange" Button bellow',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '2. You will get a Whatsapp notification containing your Code',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '3. That Code will validate by the officer or the Cashier of each brand',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Privacy & Policy',
          style: sGreyTextStyle.copyWith(fontSize: 14),
        ),
        const SizedBox(height: 5),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. This Exchange will be held from 10 September 2022 until 30 May',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '2. You can only exchange this product once',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '3. Your Point cant be gathered to other Points and cant be monetized',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
              Text(
                '4. SMI side can change this Privacy and Policy anytime without any announcement',
                style: sGreyTextStyle.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
