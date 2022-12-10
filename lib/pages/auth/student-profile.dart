// ignore_for_file: unused_field, prefer_const_constructors, use_build_context_synchronously, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:dio/dio.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sister_mobile/model/ProfileGuardian-model.dart';
import 'package:sister_mobile/pages/auth/splash-page.dart';
import 'package:skeletons/skeletons.dart';

import '../../bloc/get-profile-guardian-bloc/get_profile_guardian_bloc.dart';
import '../../bloc/get-profile-student-bloc/get_profile_student_bloc.dart';
import '../../bloc/get-profile-user-bloc/get_profile_user_bloc.dart';
import '../../model/ProfileStudent-model.dart';
import '../../model/ProfileUser.dart';
import '../../shared/theme.dart';
import '../../widget/no_scroll_waves.dart';

class StudentProfilePage extends StatefulWidget {
  final String? code;
  final bool? back;
  final bool? guardian;

  StudentProfilePage({Key? key, this.code, this.back, this.guardian})
      : super(key: key);

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final _profileBloc = GetProfileStudentBloc();
  final _guardianBloc = GetProfileGuardianBloc();
  final _userBloc = GetProfileUserBloc();

  // ! User profile

  final _userEmailController = TextEditingController();
  final _userUserNameController = TextEditingController();
  final _userReferralController = TextEditingController();

  // ! Student profile

  final _usernameStudentController = TextEditingController();
  final _mobileStudentController = TextEditingController();
  final _firstNameStudentController = TextEditingController();
  final _lastNameStudentController = TextEditingController();
  final _emailStudentController = TextEditingController();
  final _nikStudentController = TextEditingController();
  final _companyStudentController = TextEditingController();

  final _joiningStudentController = TextEditingController();
  final _knowStudentController = TextEditingController();
  final _joiningDateStudentController = TextEditingController();

  final _dateBirthStudentController = TextEditingController();
  final _placeBirthStudentController = TextEditingController();
  final _genderStudentController = TextEditingController();
  final _nationallityStudentController = TextEditingController();
  final _religionStudentController = TextEditingController();
  final _addressStudentController = TextEditingController();
  final _pincodeStudentController = TextEditingController();
  final _cityStudentController = TextEditingController();

  // ! Guardian profile

  final _guardianNameController = TextEditingController();
  final _guardianMobileNumberController = TextEditingController();
  final _guardianEmailController = TextEditingController();
  final _guardianOccupationController = TextEditingController();

  final _guardianSosmedController = TextEditingController();
  final _guardianDateBirthController = TextEditingController();
  final _guardianWorkController = TextEditingController();

  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _userBloc.add(GetProfileUserList(code: widget.code));
    _guardianBloc.add(GetProfileGuardianList(code: widget.code));
    if (widget.back != false) {
      _profileBloc.add(GetProfileList(code: widget.code));
      _guardianBloc.add(GetProfileGuardianList(code: widget.code));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _pageScaffold();
  }

  Widget _pageScaffold() {
    return Scaffold(
        backgroundColor: sBlackColor,
        appBar: AppBar(
          backgroundColor: sBlackColor,
          leading: (widget.back == null)
              ? const BackButton(color: Color(0xffC9D1D9))
              : GestureDetector(
                  onTap: () async {
                    await dio.get(
                        'https://sister.sekolahmusik.co.id/api/method/logout');
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => SplashPage()),
                        (route) => false);
                  },
                  child: Icon(
                    Icons.logout,
                    color: Color(0xffC9D1D9),
                  ),
                ),
          title: Text('My Profile',
              style: sWhiteTextStyle.copyWith(fontWeight: semiBold)),
          actions: [
            // GestureDetector(
            //   onTap: () => Navigator.pushNamed(context, '/student-point-help'),
            //   child: Container(
            //       margin: const EdgeInsets.only(right: 20),
            //       child: const Icon(Icons.save_outlined,
            //           size: 30, color: Color(0xffC9D1D9))),
            // )
          ],
        ),
        body: (widget.code == null)
            ? _buildProfileWithoutCode()
            : _buildProfileWithCode());
  }

  // ! BASIC INFORMATION
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

        // ! Joining Reason Field
        Text('Joining Reason', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: fWhiteTextStyle,
          controller: _joiningStudentController,
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

        // ! Joining Reason Date Field
        Text('Joining Date', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: fWhiteTextStyle,
          controller: _joiningDateStudentController,
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

        // ! Know From Field
        Text('Know From', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: fWhiteTextStyle,
          controller: _knowStudentController,
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
      ],
    );
  }

  Widget _buildPersonalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! title
        Text(
          'Personal Information',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff272C33),
        ),

        // ! Birth Date Field
        Text('Birth Date', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _dateBirthStudentController,
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

        // ! Birth Place Field
        Text('Birth Place', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _placeBirthStudentController,
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

        // ! Gender Field
        Text('Gender', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _genderStudentController,
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

        // ! Nationallity Field
        Text('Nationallity', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _nationallityStudentController,
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

        // ! Religion Field
        Text('Religion', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _religionStudentController,
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

        // ! Address Field
        Text('Address', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _addressStudentController,
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

        // ! Pin Code Field
        Text('Pin Code', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _pincodeStudentController,
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

        // ! City Field
        Text('City', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _cityStudentController,
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
      ],
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // ! First Name Field
        Text('First Name', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _firstNameStudentController,
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

        // ! Last Name Field
        Text('Last Name', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _lastNameStudentController,
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
          style: sWhiteTextStyle,
          controller: _mobileStudentController,
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
            hintText: 'e.x 08xx',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Email Field
        Text('Email', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _emailStudentController,
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
          style: sWhiteTextStyle,
          controller: _nikStudentController,
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

        // ! Company Field
        Text('Company', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          readOnly: true,
          style: sWhiteTextStyle,
          controller: _companyStudentController,
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
            hintText: 'e.x company',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // ! CODE EXIST
  Widget _buildProfileWithCode() {
    return ScrollConfiguration(
      behavior: NoScrollWaves(),
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (widget.guardian == true)
                    ? BlocBuilder<GetProfileGuardianBloc,
                        GetProfileGuardianState>(
                        bloc: _guardianBloc,
                        builder: (context, state) {
                          if (state is GetProfileGuardianLoaded) {
                            ProfileGuardian profile = state.guardianModel;
                            _setControllerGuardian(profile.data);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildGuardianProfileNameWithCode(profile.data),
                                _buildProfilePictureWithCode(profile.data),
                                const SizedBox(height: 15),
                                // ! Guardian Name Field
                                Text('Guardian Name', style: fTextColorStyle),
                                const SizedBox(height: 5),
                                TextFormField(
                                  style: sWhiteTextStyle,
                                  controller: _guardianNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: sBlackColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    hintText: 'e.x john doe',
                                    hintStyle: fGreyTextStyle,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                // ! Guardian Mobile Field
                                Text('Guardian Mobile', style: fTextColorStyle),
                                const SizedBox(height: 5),
                                TextFormField(
                                  style: sWhiteTextStyle,
                                  controller: _guardianMobileNumberController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: sBlackColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    hintText: 'e.x 08xx',
                                    hintStyle: fGreyTextStyle,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                // ! Guardian Email Field
                                Text('Guardian Email', style: fTextColorStyle),
                                const SizedBox(height: 5),
                                TextFormField(
                                  style: sWhiteTextStyle,
                                  controller: _guardianEmailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: sBlackColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    hintText: 'e.x john@example.com',
                                    hintStyle: fGreyTextStyle,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                // ! Guardian Occupation Field
                                Text('Guardian Occupation',
                                    style: fTextColorStyle),
                                const SizedBox(height: 5),
                                TextFormField(
                                  style: sWhiteTextStyle,
                                  controller: _guardianOccupationController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: sBlackColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    hintText: 'e.x occupation',
                                    hintStyle: fGreyTextStyle,
                                  ),
                                ),
                                const SizedBox(height: 15),

                                // ! Sosmed Field
                                Text('Guardian Sosmed', style: fTextColorStyle),
                                const SizedBox(height: 5),
                                TextFormField(
                                  style: sWhiteTextStyle,
                                  controller: _guardianSosmedController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: sBlackColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(
                                          color: Color(0XFF444C56)),
                                    ),
                                    hintText: 'e.x @',
                                    hintStyle: fGreyTextStyle,
                                  ),
                                ),
                                // _buildBasicInfo(),
                                // const SizedBox(height: 20),
                                // _buildPersonalInfo(),
                                // const SizedBox(height: 20),
                                // _buildMoreInfo(),
                                // const SizedBox(height: 20),
                                // _buildGuardianInfoWithCode(),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      )
                    : BlocBuilder<GetProfileStudentBloc,
                        GetProfileStudentState>(
                        bloc: _profileBloc,
                        builder: (context, state) {
                          if (state is GetProfileLoaded) {
                            Profile profile = state.profileModel;
                            _setControllerStudent(profile.data);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildProfileNameWithCode(profile.data),
                                _buildProfilePictureWithCode(profile.data),
                                _buildBasicInfo(),
                                const SizedBox(height: 20),
                                _buildPersonalInfo(),
                                const SizedBox(height: 20),
                                _buildMoreInfo(),
                                const SizedBox(height: 20),
                                _buildGuardianInfoWithCode(profile.data),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                const SizedBox(height: 5),
              ],
            )),
      ),
    );
  }

  Widget _buildProfileNameWithCode(profile) {
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
          profile.firstName,
          style: sWhiteTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget _buildProfilePictureWithCode(profile) {
    final image;
    if (profile.image.toString()[0] == '/') {
      image = 'https://sister.sekolahmusik.co.id${profile.image}';
    } else {
      image = profile.image.toString();
    }

    return InkWell(
      onTap: () {},
      child: (profile.image == null)
          ? Container(
              margin: const EdgeInsets.only(top: 20),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/lord-shrek.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            )
          : Container(
              margin: const EdgeInsets.only(top: 20),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            ),
    );
  }

  // ? Guardian
  Widget _buildGuardianProfileNameWithCode(profile) {
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
          profile.guardianName,
          style: sWhiteTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget _buildGuardianInfoWithCode(profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! title
        Text(
          'Guardian',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff272C33),
        ),

        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: profile.guardians.length,
            itemBuilder: ((context, index) {
              return Row(
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
                    profile.guardians[index].guardianName,
                    style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  // ! CODE NOT EXIST
  Widget _buildProfileWithoutCode() {
    return ScrollConfiguration(
      behavior: NoScrollWaves(),
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ! User Sect
                BlocBuilder<GetProfileUserBloc, GetProfileUserState>(
                  bloc: _userBloc,
                  builder: (context, state) {
                    if (state is GetProfileUserLoaded) {
                      ProfileUser user = state.modelUser;
                      _setControllerUser(user.data);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileNameWithoutCode(user.data!),
                          _buildProfilePictureWithoutCode(user.data),
                          _buildBasicUserInfo(),
                        ],
                      );
                    } else if (state is GetProfileUserLoading) {
                      return _loadingSkeleton();
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
                // ! Student Sect
                BlocBuilder<GetProfileStudentBloc, GetProfileStudentState>(
                  bloc: _profileBloc,
                  builder: (context, state) {
                    if (state is GetProfileLoaded) {
                      Profile profile = state.profileModel;
                      _setControllerStudent(profile.data);
                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                            color: Color(0xff272C33),
                          ),
                          const SizedBox(height: 10),
                          ExpandablePanel(
                            theme: ExpandableThemeData(
                              iconColor: sWhiteColor,
                              iconPadding: const EdgeInsets.all(0),
                            ),
                            header: Text(
                              'Student',
                              style: sWhiteTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 20),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              children: [
                                _buildBasicInfo(),
                                const SizedBox(height: 20),
                                _buildPersonalInfo(),
                                const SizedBox(height: 20),
                                _buildMoreInfo(),
                                const SizedBox(height: 20),
                                _buildGuardianInfoWithoutCode(),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),

                // ! Guardian Sect
                BlocBuilder<GetProfileGuardianBloc, GetProfileGuardianState>(
                  bloc: _guardianBloc,
                  builder: (context, state) {
                    if (state is GetProfileGuardianLoaded) {
                      ProfileGuardian profile = state.guardianModel;
                      _setControllerGuardian(profile.data);
                      return Column(
                        children: [
                          const Divider(
                            thickness: 1,
                            color: Color(0xff272C33),
                          ),
                          const SizedBox(height: 10),
                          ExpandablePanel(
                            theme: ExpandableThemeData(
                              iconColor: sWhiteColor,
                              iconPadding: const EdgeInsets.all(0),
                            ),
                            header: Text(
                              'Guardian',
                              style: sWhiteTextStyle.copyWith(
                                  fontWeight: semiBold, fontSize: 20),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              children: [
                                _buildGuardianInfoWithoutCode(),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildProfileNameWithoutCode(profile) {
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
          profile.firstName,
          style: sWhiteTextStyle.copyWith(
            fontWeight: semiBold,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  Widget _buildProfilePictureWithoutCode(profile) {
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

  // ? User
  Widget _buildBasicUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // ! Username Field
        Text('Username', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: fWhiteTextStyle,
          controller: _userUserNameController,
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

        // ! Email Field
        Text('Email', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: fWhiteTextStyle,
          controller: _userEmailController,
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

        // ! Referral Code Field
        Text('Referral Code', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: fWhiteTextStyle,
          controller: _userReferralController,
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
      ],
    );
  }

  // ? Student

  // ? Guardian
  Widget _buildGuardianInfoWithoutCode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // ! title
        Text(
          'Basic Information',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold, fontSize: 20),
        ),
        const Divider(
          thickness: 1,
          color: Color(0xff272C33),
        ),

        // ! Guardian Name Field
        Text('Guardian Name', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _guardianNameController,
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

        // ! Guardian Mobile Field
        Text('Guardian Mobile', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _guardianMobileNumberController,
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
            hintText: 'e.x 08xx',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Guardian Email Field
        Text('Guardian Email', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _guardianEmailController,
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

        // ! Guardian Occupation Field
        Text('Guardian Occupation', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _guardianOccupationController,
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
            hintText: 'e.x occupation',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),

        // ! Sosmed Field
        Text('Guardian Sosmed', style: fTextColorStyle),
        const SizedBox(height: 5),
        TextFormField(
          style: sWhiteTextStyle,
          controller: _guardianSosmedController,
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
            hintText: 'e.x @',
            hintStyle: fGreyTextStyle,
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  // ! GUARDIAN
  Widget _buildGuardianProfileWithCode() {
    return ScrollConfiguration(
      behavior: NoScrollWaves(),
      child: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<GetProfileGuardianBloc, GetProfileGuardianState>(
                  bloc: _guardianBloc,
                  builder: (context, state) {
                    if (state is GetProfileGuardianLoaded) {
                      ProfileGuardian profile = state.guardianModel;
                      _setControllerStudent(profile.data);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProfileNameWithCode(profile.data),
                          _buildProfilePictureWithCode(profile.data),
                          _buildBasicInfo(),
                          const SizedBox(height: 20),
                          _buildPersonalInfo(),
                          const SizedBox(height: 20),
                          _buildMoreInfo(),
                          const SizedBox(height: 20),
                          _buildGuardianInfoWithCode(profile.data),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
                const SizedBox(height: 5),
              ],
            )),
      ),
    );
  }

  Widget _buildGuardianProfilePictureWithCode(profile) {
    final image;
    if (profile.image.toString()[0] == '/') {
      image = 'https://sister.sekolahmusik.co.id${profile.image}';
    } else {
      image = profile.image.toString();
    }

    return InkWell(
      onTap: () {},
      child: (profile.image == null)
          ? Container(
              margin: const EdgeInsets.only(top: 20),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/lord-shrek.jpg'),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            )
          : Container(
              margin: const EdgeInsets.only(top: 20),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fitHeight,
                  ),
                  borderRadius: BorderRadius.circular(8)),
            ),
    );
  }

  // ! Skeleton
  Widget _loadingSkeleton() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SkeletonLine(
          style: SkeletonLineStyle(
        height: 20,
        minLength: 120,
        maxLength: 150,
      )),
      const SizedBox(height: 10),
      SkeletonAvatar(
        style: SkeletonAvatarStyle(
          shape: BoxShape.rectangle,
          width: 100,
          height: 100,
        ),
      ),
      const SizedBox(height: 20),
      SkeletonParagraph(
        style: SkeletonParagraphStyle(
            lines: 1,
            padding: EdgeInsets.symmetric(vertical: 10),
            spacing: 6,
            lineStyle: SkeletonLineStyle(
              randomLength: true,
              height: 10,
              borderRadius: BorderRadius.circular(8),
              minLength: MediaQuery.of(context).size.width / 6,
              maxLength: MediaQuery.of(context).size.width / 3,
            )),
      ),
      SkeletonAvatar(
        style: SkeletonAvatarStyle(
          shape: BoxShape.rectangle,
          width: MediaQuery.of(context).size.width,
          height: 50,
        ),
      ),
      const SizedBox(height: 20),
      SkeletonParagraph(
        style: SkeletonParagraphStyle(
            lines: 1,
            padding: EdgeInsets.symmetric(vertical: 10),
            spacing: 6,
            lineStyle: SkeletonLineStyle(
              randomLength: true,
              height: 10,
              borderRadius: BorderRadius.circular(8),
              minLength: MediaQuery.of(context).size.width / 6,
              maxLength: MediaQuery.of(context).size.width / 3,
            )),
      ),
      SkeletonAvatar(
        style: SkeletonAvatarStyle(
          shape: BoxShape.rectangle,
          width: MediaQuery.of(context).size.width,
          height: 50,
        ),
      ),
      const SizedBox(height: 20),
      SkeletonParagraph(
        style: SkeletonParagraphStyle(
            lines: 1,
            padding: EdgeInsets.symmetric(vertical: 10),
            spacing: 6,
            lineStyle: SkeletonLineStyle(
              randomLength: true,
              height: 10,
              borderRadius: BorderRadius.circular(8),
              minLength: MediaQuery.of(context).size.width / 6,
              maxLength: MediaQuery.of(context).size.width / 3,
            )),
      ),
      SkeletonAvatar(
        style: SkeletonAvatarStyle(
          shape: BoxShape.rectangle,
          width: MediaQuery.of(context).size.width,
          height: 50,
        ),
      ),
      const SizedBox(height: 20)
    ]);
  }

  // ! set controller
  _setControllerStudent(profile) {
    _usernameStudentController.text = profile.firstName;
    _mobileStudentController.text = profile.studentMobileNumber;
    _firstNameStudentController.text = profile.firstName;
    _lastNameStudentController.text =
        profile.lastName == null ? '' : profile.lastName;
    _emailStudentController.text = profile.studentEmailId;
    _nikStudentController.text = (profile.nis == null) ? '' : profile.nis;
    _companyStudentController.text = profile.company;

    _dateBirthStudentController.text = profile.dateOfBirth;
    _placeBirthStudentController.text = profile.placeOfBirth;
    _genderStudentController.text = profile.gender;
    _nationallityStudentController.text = profile.nationality;
    _religionStudentController.text = profile.religion;
    _addressStudentController.text = profile.addressLine1;
    _pincodeStudentController.text = profile.pincode;
    _cityStudentController.text = profile.city;

    _joiningStudentController.text = profile.reasonJoining;
    _joiningDateStudentController.text = profile.joiningDate;
    _knowStudentController.text = profile.knowFrom;
  }

  _setControllerGuardian(profile) {
    _guardianNameController.text = profile.guardianName;
    _guardianMobileNumberController.text = profile.mobileNumber;
    _guardianEmailController.text = profile.emailAddress;
    _guardianOccupationController.text = profile.occupation.toString();
    _guardianSosmedController.text = profile.igUser.toString();
  }

  _setControllerUser(profile) {
    _userEmailController.text = profile.email;
    _userUserNameController.text =
        (profile.username == null) ? '' : profile.username;
    _userReferralController.text =
        (profile.referralCode == null) ? '' : profile.referralCode;
  }
}
