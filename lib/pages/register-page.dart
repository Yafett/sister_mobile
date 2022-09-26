// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var unitList = ['', ''];
    var genderList = ['Boy', 'Girl', 'Other'];
    var unitval;
    return _buildRegisterPage(context, unitList, genderList, unitval);
  }

  Widget _buildRegisterPage(
      context, List<String> unitList, genderList, unitval) {
    return Scaffold(
        backgroundColor: const Color(0xffE8E8E8),
        appBar: AppBar(
            leadingWidth: double.infinity,
            elevation: 0,
            backgroundColor: const Color(0xffE8E8E8),
            leading: SizedBox(
              child: Row(
                children: [
                  IconButton(
                      padding: const EdgeInsets.all(0),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios,
                          color: Colors.black)),
                  Text(
                    'Register',
                    style: fBlackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  )
                ],
              ),
            )),
        body: ScrollConfiguration(
          behavior: NoScrollWaves(),
          child: SingleChildScrollView(
              child: Column(
            children: [
              _buildUnitInformation(context, unitList, unitval),
              _buildStudentInformation(context, genderList, unitval),
              _buildAdditionalInformation(context),
            ],
          )),
        ));
  }

  Widget _buildUnitInformation(context, List<String> unitList, unitval) {
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

            // ! Name Field
            Text('Name', style: fTextColorStyle),
            const SizedBox(height: 5),
            TextFormField(
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
                items: unitList.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text(item.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {},
                value: unitval,
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
                items: unitList.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text(item.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {},
                value: unitval,
              ),
            ),
            const SizedBox(height: 15),

            // ! QR Field
            Text('QR', style: fTextColorStyle),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
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

  Widget _buildStudentInformation(context, List<String> genderList, unitval) {
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
                items: genderList.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text(item.toString()),
                  );
                }).toList(),
                onChanged: (newVal) {},
                value: unitval,
              ),
            ),
            const SizedBox(height: 15),

            // ! Birth Date Field
            Text('Birth Date', style: fTextColorStyle),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {},
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
}
