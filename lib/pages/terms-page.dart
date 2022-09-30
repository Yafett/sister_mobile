import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

import 'dart:ui' as ui;
import '../shared/theme.dart';

class TermPage extends StatefulWidget {
  const TermPage({Key? key}) : super(key: key);

  @override
  State<TermPage> createState() => _TermPageState();
}

class _TermPageState extends State<TermPage> {
  SignatureController controller = SignatureController();

  @override
  void initState() {
    super.initState();
    controller = SignatureController(penColor: Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      appBar: AppBar(
          title: Text(
            'Terms and Conditions',
            style: fBlackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          elevation: 0,
          backgroundColor: const Color(0xffE8E8E8),
          leading: SizedBox(
            child: Row(
              children: [
                IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.arrow_back_ios, color: Colors.black)),
              ],
            ),
          )),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: Column(children: [
            _buildMedicalRelease(),
            _buildDocumentationRelease(),
            _buildStudentDetail(),
            _buildGuardianDetail(),
            _buildCourseDetail(),
            _buildAdditionalDetail(),
            _buildSignaturePad(),
            _buildRegisterButton()
          ]),
        ),
      ),
    );
  }

  Widget _studentTextLine(String key, String value) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.30,
                child: Text(
                  key,
                  style: fGreyTextStyle.copyWith(
                      color: const Color(0xff616161),
                      fontSize: 16,
                      fontWeight: semiBold),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                child: Text(
                  ':',
                  style: fGreyTextStyle.copyWith(
                      color: const Color(0xff616161),
                      fontSize: 16,
                      fontWeight: semiBold),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: fGreyTextStyle.copyWith(
                      color: const Color(0xff8E8E8E),
                      fontSize: 16,
                      fontWeight: semiBold),
                )),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _courseTextLine(course, String durationValue, String placeValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course,
                style: fGreyTextStyle.copyWith(
                    color: const Color(0xff313131),
                    fontSize: 16,
                    fontWeight: semiBold),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          'Duration',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          ':',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          durationValue,
                          overflow: TextOverflow.ellipsis,
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff8E8E8E),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          'Place',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          ':',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          placeValue,
                          overflow: TextOverflow.ellipsis,
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff8E8E8E),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _teacherTextLine(
      course, jobValue, mobileValue, emailValue, sosmedValue) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course,
                style: fGreyTextStyle.copyWith(
                    color: const Color(0xff313131),
                    fontSize: 16,
                    fontWeight: semiBold),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          'Job',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          ':',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          jobValue,
                          overflow: TextOverflow.ellipsis,
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff8E8E8E),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          'Mobile',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          ':',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          mobileValue,
                          overflow: TextOverflow.ellipsis,
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff8E8E8E),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          'Email',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          ':',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          emailValue,
                          overflow: TextOverflow.ellipsis,
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff8E8E8E),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, top: 5),
                child: Row(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.30,
                        child: Text(
                          'Sosmed',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                        child: Text(
                          ':',
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff616161),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          sosmedValue,
                          overflow: TextOverflow.ellipsis,
                          style: fGreyTextStyle.copyWith(
                              color: const Color(0xff8E8E8E),
                              fontSize: 16,
                              fontWeight: semiBold),
                        )),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _buildMedicalRelease() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medical Release',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Text(
              'We authorize the Indonesian Music School to provide first aid and take students to the nearest hospital in case of an emergency (parents/guardians cannot be contacted)',
              style: fTermsColorStyle,
            )
          ],
        ));
  }

  Widget _buildDocumentationRelease() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Documentation Release',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Text(
              "We gave a permit to the Indonesian Music School to make image and sound recordings for our/our children. SMI may use these recordings for audio-visual programs for educational, promotional, and informational purposes in connection with SMI's activities.",
              style: fTermsColorStyle,
            )
          ],
        ));
  }

  Widget _buildStudentDetail() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Release',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Column(
              children: [
                _studentTextLine('Name', 'Yafet Rama'),
                _studentTextLine('Known From', 'Sering lewat'),
                _studentTextLine('Joining Reason', 'other'),
                _studentTextLine('Mobile', '082176997057'),
                _studentTextLine('Email', 'yafhet2004@gmail.com'),
                _studentTextLine('Unit', 'Puri Anjasmoro'),
                _studentTextLine('Nickname', 'Yafet'),
                _studentTextLine('Gender', 'Boy'),
                _studentTextLine('Birth Date', '20 June 2022'),
                _studentTextLine('Birth Place', 'Semarang'),
                _studentTextLine('Religion', 'Other'),
                _studentTextLine('Nationallity', 'WNI'),
                _studentTextLine('Address',
                    'Sekolah Musik Indonesia Puri Anjasmoro, 29JQ+3X8, Tawangsari, Kec. Semarang Barat, Kota Semarang, Jawa Tengah 50144'),
                _studentTextLine('City', 'Semarang'),
                _studentTextLine('Postal Code', '8120'),
                _studentTextLine('School', 'SMK Bagimu Negeriku'),
                _studentTextLine('Sosmed', 'joo'),
              ],
            )
          ],
        ));
  }

  Widget _buildGuardianDetail() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Guardian Release',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Column(
              children: [
                _teacherTextLine(
                  'Other - Yasuo',
                  'Big Developer',
                  '130980193801',
                  'yasuo@gmail.com',
                  '@yasuo',
                ),
                _teacherTextLine(
                  'Mother - Ahri',
                  'Big Developer',
                  '130980193801',
                  'ahri@gmail.com',
                  '@ahri',
                ),
              ],
            )
          ],
        ));
  }

  Widget _buildCourseDetail() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Course Release',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Column(
              children: [
                _courseTextLine('FAS / Privacy Class - Guitar',
                    'Lite, 30 Minutes', 'At SMI'),
                _courseTextLine('FAS / Privacy Class - Vocal',
                    'Regular, 45 Minutes', 'At SMI'),
              ],
            )
          ],
        ));
  }

  Widget _buildAdditionalDetail() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Additional Release',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 10),
            Column(
              children: [
                _studentTextLine('QR', 'none'),
                _studentTextLine('Re-pregistration', 'yes'),
                _studentTextLine('Search', 'none'),
              ],
            )
          ],
        ));
  }

  Widget _buildSignaturePad() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0XFFF8F9FA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Release',
            style: fBlackTextStyle.copyWith(
              fontSize: 20,
            ),
          ),
          const Divider(thickness: 1),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "We have read and understand the terms and conditions. and states that they are willing to follow the rules and regulations that apply at the Indonesian Music School. \n"),
              Text(
                'Please sign or write your name below.',
                style: fBlackTextStyle.copyWith(),
              ),
              Container(
                child: Signature(
                  controller: controller,
                  backgroundColor: Colors.white,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Row(
                children: [
                  Material(
                    child: InkWell(
                      onTap: () => controller.clear(),
                      splashColor: Colors.white,
                      child: Material(
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Color(0xffE22426),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                              child: Text(
                            'Clear',
                            style:
                                fWhiteTextStyle.copyWith(fontWeight: semiBold),
                          )),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (controller.isNotEmpty) {
                        final signature = await exportSignature();
                      }
                    },
                    splashColor: Colors.white,
                    child: Material(
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color(0xffE22426),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Center(
                            child: Text(
                          'Save',
                          style: fWhiteTextStyle.copyWith(fontWeight: semiBold),
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRegisterButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            'Submit',
            style: fBlackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    print(signature.toString());

    final status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }

    final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    final name = 'signature_$time.png';

    final result = await ImageGallerySaver.saveImage(signature!, name: name);
    final isSuccess = result['isSuccess'];

    if (isSuccess) {
      print('success');
    }
    return signature;
  }
}
