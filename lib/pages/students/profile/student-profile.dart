import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({Key? key}) : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return _buildProfilePage();
  }

  Widget _buildProfilePage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text('My Profile',
            style: sWhiteTextStyle.copyWith(fontWeight: semiBold)),
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/student-point-help'),
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.save_outlined,
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
                  _buildProfileName(),
                  _buildProfilePicture(),
                  const SizedBox(height: 50),
                  _buildBasicInfo(),
                  const SizedBox(height: 20),
                  _buildMoreInfo(),
                  const SizedBox(height: 20),
                  _buildRole(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildProfileName() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          height: 20,
          width: 10,
          decoration: BoxDecoration(
            color: sGreenColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        Text(
          'Beatrice',
          style: sWhiteTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget _buildProfilePicture() {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.red,
            image: const DecorationImage(
              image: AssetImage('assets/images/lord-shrek.jpg'),
              fit: BoxFit.fitHeight,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  Widget _buildMoreInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! title
        Text(
          'More Information',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff272C33),
        ),

        // ! Gender Field
        Text('Gender', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x john doe',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Mobile Field
        Text('Mobile', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x john',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Birth Field
        Text('Birth (optional)', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x midname',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Location Field
        Text('Location', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x doe',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Bio Field
        Text('Bio', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x john@example.com',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! title
        Text(
          'Basic Information',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff272C33),
        ),

        // ! username Field
        Text('Username', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x john doe',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Mobile Field
        Text('Mobile', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x john',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Middle name Field
        Text('Middle Name (optional)', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x midname',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Last Name Field
        Text('Last Name', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x doe',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Email Field
        Text('Email', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x john@example.com',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! NIK Field
        Text('NIK', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            fillColor: sBlackColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0XFF444C56)),
            ),
            hintText: 'e.x nik',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildRole() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! title
        Text(
          'Role',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff272C33),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              height: 30,
              width: 20,
              child: Checkbox(
                checkColor: sBlackColor,
                activeColor: sBlueColor,
                value: true,
                onChanged: (value) {
                  setState(() {
                    value;
                  });
                },
              ),
            ),
            Text(
              'HR Manager',
              style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              height: 30,
              width: 20,
              child: Checkbox(
                checkColor: sBlackColor,
                activeColor: sBlueColor,
                value: true,
                onChanged: (value) {
                  setState(() {
                    value;
                  });
                },
              ),
            ),
            Text(
              'Project User ',
              style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              height: 30,
              width: 20,
              child: Checkbox(
                checkColor: sBlackColor,
                activeColor: sBlueColor,
                value: true,
                onChanged: (value) {
                  setState(() {
                    value;
                  });
                },
              ),
            ),
            Text(
              'Instructor',
              style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              height: 30,
              width: 20,
              child: Checkbox(
                checkColor: sBlackColor,
                activeColor: sBlueColor,
                value: true,
                onChanged: (value) {
                  setState(() {
                    value;
                  });
                },
              ),
            ),
            Text(
              'Leave Approver',
              style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
            ),
          ],
        ),
      ],
    );
  }
}
