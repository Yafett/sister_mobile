// ignore_for_file: file_names, prefer_typing_uninitialized_variables, sized_box_for_whitespace, avoid_unnecessary_containers, unused_local_variable, unused_field, avoid_print, unused_element, use_build_context_synchronously, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sister_mobile/resources/auth-provider.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:http/http.dart' as http;

import '../../resources/data-provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var dio = Dio();
  var cookieJar = CookieJar();

  var knowFromVal;
  var joiningVal;
  var genderVal;
  var unitVal;
  var photoName;
  var classFormatVal;
  var classDurationVal;
  var classMajorVal;
  var classTypeVal;
  var guardianList;
  var courseList;
  var relationVal;

  bool addParents = false;
  bool addCourse = false;

  List<dynamic> listCourse = [];
  List<dynamic> listParents = [];

  List<String> listUnit = [];
  List<String> listKnowFrom = [];
  List<String> listGender = [];
  List<String> listJoiningReason = [];
  List<String> listClassType = ['At SMI', 'Online', 'GO'];
  List<String> listClassMajor = [];
  List<String> listRelationship = ['Father', 'Mother', 'Other'];
  List<String> listClassPrivateMajor = [
    'Drum',
    'Piano',
    'Vocal',
    'Guitar',
    'Violin',
    'Bass',
    'Saxophone',
    'Flute'
  ];
  List<String> listClassGroupMajor = [
    'Group',
    'Drum',
    'Piano',
    'Vocal',
    'Guitar',
    'Violin',
    'Bass',
    'Saxophone',
    'Flute'
  ];
  List<String> listClassFOMMajor = [
    'Drum',
    'FOM Fun',
    'FOM Learn',
  ];
  List<String> listClassFormat = [
    'FAS / Private',
    'Harmony / Group',
    'FoM',
    'Ensemble'
  ];
  List<String> listClassDuration = [
    'Lite : 30 Minutes',
    'Regular : 45 Minutes',
    'Premium : 60 Minutes',
  ];
  List<String> listClassCode = [];
  List<String> listClassGrading = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _knowController = TextEditingController();
  final TextEditingController _joiningController = TextEditingController();
  final TextEditingController _qrController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _sosmedController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _birthplaceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _religionController = TextEditingController();
  final TextEditingController _idnumController = TextEditingController();
  final TextEditingController _nationController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  final TextEditingController _schoolController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();

  final TextEditingController _guardNameController = TextEditingController();
  final TextEditingController _guardRelationshipController =
      TextEditingController();
  final TextEditingController _guardEmailController = TextEditingController();
  final TextEditingController _guardWhatsappController =
      TextEditingController();
  final TextEditingController _guardOccupationController =
      TextEditingController();
  final TextEditingController _guardSosmedController = TextEditingController();

  final authProvider = AuthProvider();
  final dataProvider = DataProvider();

  @override
  void initState() {
    _fetchJoiningReason();
    _fetchKnowFrom();
    _fetchGender();
    _fetchUnit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildRegisterPage(context);
  }

  Widget _buildRegisterPage(context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      appBar: AppBar(
          title: Text(
            'Register',
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
          child: Column(
            children: [
              _buildUnitInformation(context),
              _buildStudentInformation(context),
              _buildAdditionalInformation(context),
              _buildParentInformation(context),
              _buildCourseInformation(context),
              _buildRegisterButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUnitInformation(context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
              'Unit Information',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 15),

            // ! Unit Field
            Text('Unit', style: fTextColorStyle),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0XFFE8E8E8)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                hint: Text('e.x relation', style: fGreyTextStyle),
                items: listUnit.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text(item.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    unitVal = newVal;
                  });
                },
                value: unitVal,
              ),
            ),
            const SizedBox(height: 15),

            // ! Name Field
            Text('Name', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x John Doe',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Known From Field
            Text('Known From', style: fTextColorStyle),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0XFFE8E8E8)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                hint: Text('e.x City', style: fGreyTextStyle),
                items: listKnowFrom.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text(item.toString().toLowerCase()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    knowFromVal = newVal;
                  });
                },
                value: knowFromVal,
              ),
            ),
            const SizedBox(height: 15),

            // ! Joining Reason Field
            Text('Joining Reason', style: fTextColorStyle),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0XFFE8E8E8)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                underline: const SizedBox(),
                isExpanded: true,
                hint: Text('e.x Reason', style: fGreyTextStyle),
                items: listJoiningReason.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text(item.toString().toLowerCase()),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    joiningVal = newVal;
                  });
                },
                value: joiningVal,
              ),
            ),
            const SizedBox(height: 15),

            // ! QR Field
            Text('QR', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _qrController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      _getDataFromCamera();
                    },
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      color: Color(0xff616161),
                    )),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x QR-Code',
                hintStyle: fGreyTextStyle,
              ),
            ),
          ],
        ));
  }

  Widget _buildStudentInformation(context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
              'Student Information',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 15),

            // ! Fullname Field
            Text('Fullname', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _fullnameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x John Doe',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Nickname Field
            Text('Nickname', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _nicknameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x John',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Email Field
            Text('Email', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x john@example.com',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Whatsapp Field
            Text('Whatsapp Number', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _whatsappController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x 0821xxxxx',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Gender Field
            Text('Gender', style: fTextColorStyle),
            Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0XFFE8E8E8)),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  hint: Text('e.x boy', style: fGreyTextStyle),
                  items: listGender.map((item) {
                    return DropdownMenuItem(
                      value: item.toString(),
                      child: Text(item.toString()),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      genderVal = newVal;
                    });
                  },
                  value: genderVal),
            ),
            const SizedBox(height: 15),

            // ! Birth Date Field
            Text('Birth Date', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _birthdateController,
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(
                              2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16

                        _birthdateController.text = formattedDate;
                      } else {
                        print("Date is not selected");
                      }
                    },
                    icon: const Icon(
                      Icons.date_range,
                      color: Color(0xff616161),
                    )),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x dd:mm:yyyy',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Birth Place Field
            Text('Birth Place', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _birthplaceController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x place',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Address Field
            Text('Address', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _addressController,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x jl.xxxxx',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! City Field
            Text('City', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _cityController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x city',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Religion Field
            Text('Religion', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _religionController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x religion',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ));
  }

  Widget _buildAdditionalInformation(context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
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
              'Additional Information',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 15),

            // ! ID Number Field
            Text('ID Number (KTP)', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _idnumController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x xxxx',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Nationallity Field
            Text('Nationallity', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _nationController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x region',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! Postal Code Field
            Text('Postal Code', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _postalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x xxxx',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),

            // ! School Name Field
            Text('School Name', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
              controller: _schoolController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
                ),
                hintText: 'e.x school',
                hintStyle: fGreyTextStyle,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ));
  }

  Widget _buildParentInformation(context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Parent Information',
                  style: fBlackTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      addParents = true;
                    });
                  },
                  icon: const Icon(Icons.add),
                  padding: const EdgeInsets.all(0),
                )
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 15),
            _buildAddParents()
          ],
        ));
  }

  Widget _buildCourseInformation(context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0XFFF8F9FA),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Course Information',
                  style: fBlackTextStyle.copyWith(
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      addCourse = true;
                    });
                    print(addCourse);
                  },
                  icon: const Icon(Icons.add),
                  padding: const EdgeInsets.all(0),
                )
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notes : ',
                  style: fBlackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\u2022 FOM class is for 3-5 yo',
                  style: fBlackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                Text(
                  '\u2022 FAS class is for 5 yo above',
                  style: fBlackTextStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            _buildAddCourse(),
          ],
        ));
  }

  Widget _buildRegisterButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              register();
            },
            child: Text(
              'Submit',
              style: fBlackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }

  Widget _buildAddParents() {
    if (addParents == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! Name Field
          Text('Name', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            controller: _guardNameController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              hintText: 'e.x region',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Relationship Field
          Text('Relationship', style: fTextColorStyle),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0XFFE8E8E8)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text('e.x relation', style: fGreyTextStyle),
              items: listRelationship.map((item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  relationVal = newVal;
                });
              },
              value: relationVal,
            ),
          ),
          const SizedBox(height: 15),

          // ! Email Field
          Text('Email', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            controller: _guardEmailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              hintText: 'e.x region',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Whatsapp Field
          Text('Whatsapp', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            controller: _guardWhatsappController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              hintText: 'e.x region',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Occupation Field
          Text('Occupation', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            controller: _guardOccupationController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              hintText: 'e.x region',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Sosmed Field
          Text('Sosmed', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            controller: _guardSosmedController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0XFFE8E8E8)),
              ),
              hintText: 'e.x region',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),
          const SizedBox(height: 15),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  addParentsToList(
                    _guardNameController.text,
                    relationVal,
                    _guardEmailController.text,
                    _guardWhatsappController.text,
                    _guardOccupationController.text,
                    _guardSosmedController.text,
                  );
                  setState(() {
                    addParents = false;
                  });
                },
                splashColor: Colors.white,
                child: Material(
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffE22426),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: fWhiteTextStyle.copyWith(fontWeight: semiBold),
                    )),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    addParents = false;
                  });
                },
                splashColor: Colors.white,
                child: Material(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffE22426),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'Cancel',
                      style: fWhiteTextStyle.copyWith(fontWeight: semiBold),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (addParents == false) {
      return Container(
        height: 120 * listParents.length.toDouble(),
        child: ListView.builder(
          itemCount: listParents.length,
          itemBuilder: ((context, index) {
            print(listParents[index]);
            return _buildParentInformationCard(
                index,
                listParents[index]['relation'],
                listParents[index]['name'],
                listParents[index]['email'],
                listParents[index]['job'],
                listParents[index]['mobile'],
                listParents[index]['sosmed']);
          }),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildAddCourse() {
    if (addCourse == true) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ! Class Format Field
          Text('Class Format', style: fTextColorStyle),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0XFFE8E8E8)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text('e.x format', style: fGreyTextStyle),
              items: listClassFormat.map((item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  classFormatVal = newVal;
                });
              },
              value: classFormatVal,
            ),
          ),
          const SizedBox(height: 15),

          // ! Class Major Field
          Text('Class Major', style: fTextColorStyle),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0XFFE8E8E8)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text('e.x major', style: fGreyTextStyle),
              items: listClassPrivateMajor.map((item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  classMajorVal = newVal;
                });
              },
              value: classMajorVal,
            ),
          ),
          const SizedBox(height: 15),

          // ! Class Duration  Field
          Text('Class Duration ', style: fTextColorStyle),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0XFFE8E8E8)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text('e.x duration', style: fGreyTextStyle),
              items: listClassDuration.map((item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  classDurationVal = newVal;
                });
              },
              value: classDurationVal,
            ),
          ),
          const SizedBox(height: 15),

          // ! Class Type Field
          Text('Class Type', style: fTextColorStyle),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0XFFE8E8E8)),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButton(
              underline: const SizedBox(),
              isExpanded: true,
              hint: Text('e.x type', style: fGreyTextStyle),
              items: listClassType.map((item) {
                return DropdownMenuItem(
                  value: item.toString(),
                  child: Text(item.toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  classTypeVal = newVal;
                });
              },
              value: classTypeVal,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              InkWell(
                onTap: () async {
                  addCourseToList();
                  setState(() {
                    addCourse = false;
                  });
                },
                splashColor: Colors.white,
                child: Material(
                  child: Container(
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffE22426),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'Submit',
                      style: fWhiteTextStyle.copyWith(fontWeight: semiBold),
                    )),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  setState(() {
                    addCourse = false;
                  });

                  print(addCourse);
                },
                splashColor: Colors.white,
                child: Material(
                  child: Container(
                    margin: const EdgeInsets.only(left: 5),
                    height: 30,
                    width: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xffE22426),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'Cancel',
                      style: fWhiteTextStyle.copyWith(fontWeight: semiBold),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (addCourse == false) {
      return Container(
        height: 120 * listCourse.length.toDouble(),
        child: ListView.builder(
          itemCount: listCourse.length,
          itemBuilder: ((context, index) {
            var name = listCourse[index]['format'].toString();
            return _buildCourseCard(
              index,
              listCourse[index]['duration'].toString(),
              listCourse[index]['format'].toString(),
              listCourse[index]['major'].toString(),
              listCourse[index]['type'].toString(),
            );
          }),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _buildCourseCard(index, major, className, duration, type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            color: Color(0xffDFDFDF),
          ),
          height: 100,
          width: 100,
          child: Icon(
            _checkIconCourse(major),
            color: const Color(0xff313131),
            size: 50,
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(className,
                          style: fBlackTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      GestureDetector(
                          onTap: () {
                            removeCourseOnList(index);
                          },
                          child: const Icon(Icons.close_rounded)),
                    ]),
                Row(
                  children: [
                    // ! sect 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 5),
                                    child: const Icon(
                                      Icons.watch_later_outlined,
                                      size: 20,
                                      color: Color(0XFF8E8E8E),
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(duration,
                                            overflow: TextOverflow.ellipsis,
                                            style: fTextColorStyle.copyWith()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: const Icon(
                                Icons.location_on_outlined,
                                size: 20,
                                color: Color(0XFF8E8E8E),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Container(
                                child: SizedBox(
                                  child: Text(type,
                                      overflow: TextOverflow.ellipsis,
                                      style: fTextColorStyle.copyWith()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // ! sect 2
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.music_note_outlined,
                            size: 20,
                            color: Color(0XFF8E8E8E),
                          ),
                          Container(
                            width: 50,
                            child: Container(
                              child: SizedBox(
                                child: Text(major,
                                    overflow: TextOverflow.ellipsis,
                                    style: fTextColorStyle.copyWith()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget _buildParentInformationCard(
      index, relation, name, email, job, mobile, sosmed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            color: _checkIconColor(relation),
          ),
          height: 100,
          width: 100,
          child: Icon(
            _checkIconParents(relation),
            color: Colors.white,
            size: 50,
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(name,
                          style: fBlackTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Icon(Icons.close_rounded),
                    ]),
                Row(
                  children: [
                    // ! sect 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    child: const Icon(
                                      Icons.mail_outline,
                                      size: 20,
                                      color: Color(0XFF8E8E8E),
                                    ),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(email,
                                            overflow: TextOverflow.ellipsis,
                                            style: fTextColorStyle.copyWith()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 3),
                              child: const Icon(
                                Icons.work_outline,
                                size: 20,
                                color: Color(0XFF8E8E8E),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Container(
                                child: SizedBox(
                                  child: Text(job,
                                      overflow: TextOverflow.ellipsis,
                                      style: fTextColorStyle.copyWith()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // ! sect 2
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    child: const Icon(
                                      Icons.phone,
                                      size: 20,
                                      color: Color(0XFF8E8E8E),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(mobile,
                                            overflow: TextOverflow.ellipsis,
                                            style: fTextColorStyle.copyWith()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 3),
                              child: const Icon(
                                Icons.alternate_email,
                                size: 20,
                                color: Color(0XFF8E8E8E),
                              ),
                            ),
                            Container(
                              width: 60,
                              child: Container(
                                child: SizedBox(
                                  child: Text(sosmed,
                                      overflow: TextOverflow.ellipsis,
                                      style: fTextColorStyle.copyWith()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  // ! auth function

  register() async {
    var test = json.encode(<String, dynamic>{
      "data": {
        "unit": unitVal,
        "search": "",
        "qr": _qrController.text,
        "guardian": listParents,
        "know": knowFromVal,
        "reason": joiningVal,
        "school": _schoolController.text,
        "sosmed": _sosmedController.text,
        "mobile": _whatsappController.text,
        "email": _emailController.text,
        "nik": _nikController.text,
        "daftar_ulang": true,
        "follow_up": "",
        "mgm": "",
        "full_name": _fullnameController.text.toUpperCase(),
        "nick_name": _nicknameController.text,
        "place": _birthplaceController.text,
        "religion": _religionController.text,
        "gender": genderVal,
        "national": _nationController.text,
        "city": _cityController.text,
        "postal_code": _postalController.text,
        "date_of_birth": _birthdateController.text,
        "address": _addressController.text,
        "course": listCourse,
        "sign": true
      }
    });

    final response = await http.post(
        Uri.parse(
            'https://${baseUrl}.sekolahmusik.co.id/api/method/smi.api.registrasi_student'),
        headers: {
          'content-type': 'application/json',
          'Authorization': "token ee4b62270c9f599:88a96322d318005",
        },
        body: test);

    if (response.statusCode == 200) {
      Navigator.pushNamed(context, '/home');
    }
  }

  addParentsToList(name, relation, email, wa, occupation, sosmed) {
    listParents.add({
      "name": name.toString().toUpperCase(),
      "relation": relation,
      "email": email,
      "mobile": wa,
      "job": occupation,
      "sosmed": sosmed,
    });

    relationVal = null;
    _guardNameController.text = '';
    _guardEmailController.text = '';
    _guardWhatsappController.text = '';
    _guardOccupationController.text = '';
    _guardSosmedController.text = '';

    print(listParents);
  }

  addCourseToList() {
    listCourse.add({
      "format": classFormatVal,
      "major": classMajorVal,
      "duration": classDurationVal,
      "type": classTypeVal
    });

    classFormatVal = null;
    classMajorVal = null;
    classDurationVal = null;
    classTypeVal = null;
    print(listCourse);
  }

  removeCourseOnList(index) {
    setState(() {
      listCourse.removeAt(index);
    });
    print(listCourse);
  }

  // ! fetch data

  _fetchJoiningReason() async {
    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });
    final request = await dio.get(
        "https://${baseUrl}.sekolahmusik.co.id/api/resource/Reason For Joining");
    var data = request.data['data'];

    for (var a = 0; a < data.length; a++) {
      if (mounted) {
        setState(() {
          listJoiningReason
              .add(request.data['data'][a]['name'].toString().capitalize!);
        });
      }
    }
  }

  _fetchKnowFrom() async {
    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });
    final request = await dio
        .get("https://${baseUrl}.sekolahmusik.co.id/api/resource/Know From");
    var data = request.data['data'];

    for (var a = 0; a < data.length; a++) {
      setState(() {
        listKnowFrom
            .add(request.data['data'][a]['name'].toString().capitalize!);
      });
    }
  }

  _fetchUnit() async {
    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });
    final request = await dio
        .get("https://${baseUrl}.sekolahmusik.co.id/api/resource/Company");
    var data = request.data['data'];

    for (var a = 0; a < data.length; a++) {
      setState(() {
        listUnit.add(request.data['data'][a]['name']);
      });
    }
  }

  _fetchGender() async {
    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });
    final request = await dio
        .get("https://${baseUrl}.sekolahmusik.co.id/api/resource/Gender");
    var data = request.data['data'];

    for (var a = 0; a < data.length; a++) {
      setState(() {
        listGender.add(request.data['data'][a]['name']);
      });
    }
  }

  // ! set value

  _setClassFormat(cf) {
    if (cf == 'PR') {
      return print('Private');
    } else if (cf == 'GR') {
      return print('Group');
    }
  }

  _setClassGrade(cf) {
    if (cf == '21') {
      return print('CFK 1');
    } else if (cf == '22') {
      return print('CFK 2');
    } else if (cf == '31') {
      return print('JC 1');
    } else if (cf == '32') {
      return print('JC 2');
    } else if (cf == '33') {
      return print('JC 3');
    } else if (cf == '34') {
      return print('JC 4');
    } else if (cf == '35') {
      return print('JC 5');
    } else if (cf == '36') {
      return print('JC 6');
    } else if (cf == '00') {
      return print('No Grade');
    } else if (cf == '01') {
      return print('Kids');
    } else if (cf == '02') {
      return print('Beginner');
    } else if (cf == '03') {
      return print('Intermediate');
    } else if (cf == '04') {
      return print('Advanced');
    } else if (cf == '11') {
      return print('Fun');
    } else if (cf == '12') {
      return print('Learn');
    } else if (cf == '91') {
      return print('Grade 1');
    } else if (cf == '92') {
      return print('Grade 2');
    } else if (cf == '93') {
      return print('Grade 3');
    } else if (cf == '94') {
      return print('Grade 4');
    } else if (cf == '95') {
      return print('Grade 5');
    } else if (cf == '3966') {
      return print('Grade 6');
    }
  }

  _setClassType(cf) {
    if (cf == '1') {
      return print('At SMI');
    } else if (cf == '2') {
      return print('Online');
    } else if (cf == '3') {
      return print('GO');
    }
  }

  _setClassDuration(cf) {
    if (cf == '1') {
      return print('Lite, 30 Minutes');
    } else if (cf == '2') {
      return print('Regular, 45 Minutes');
    } else if (cf == '3') {
      return print('Premium, 60 Minutes');
    }
  }

  _setClassMajor(cf) {
    if (cf == 'MM') {
      return print('Multi - Mayor');
    } else if (cf == 'PI') {
      return print('Piano');
    } else if (cf == 'DR') {
      return print('Drum');
    } else if (cf == 'VO') {
      return print('Vocal');
    } else if (cf == 'EG') {
      return print('Electric Guitar');
    } else if (cf == 'AG') {
      return print('Accoustic Guitar');
    } else if (cf == 'BA') {
      return print('Bass');
    } else if (cf == 'VI') {
      return print('Violin');
    } else if (cf == 'SA') {
      return print('Saxophone');
    } else if (cf == 'FL') {
      return print('Flute');
    } else if (cf == 'CE') {
      return print('Cello');
    }
  }

  _checkIconCourse(major) {
    if (major == 'Piano') {
      return Icons.piano;
    } else if (major == 'Vocal') {
      return Icons.mic;
    } else {
      return Icons.question_mark_sharp;
    }
  }

  _checkIconParents(relation) {
    if (relation == 'Father') {
      return Icons.boy;
    } else if (relation == 'Mother') {
      return Icons.girl;
    } else {
      return Icons.question_mark_sharp;
    }
  }

  _checkIconColor(relation) {
    if (relation == 'Father') {
      return const Color(0xff2D7AB1);
    } else if (relation == 'Mother') {
      return const Color(0xffC8239A);
    } else {
      return const Color(0xff616161);
    }
  }

  _getDataFromCamera() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo?.name != null) {
      setState(() {
        photoName = photo!.name;
      });
    }
  }
}
