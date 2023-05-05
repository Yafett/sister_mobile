// ignore_for_file: use_build_context_synchronously

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
  final String? email;
  final bool? back;
  final bool? guardian;
  final bool? student;

  const StudentProfilePage(
      {Key? key, this.code, this.email, this.back, this.guardian, this.student})
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
  final _userFirstNameController = TextEditingController();
  final _userLastNameController = TextEditingController();
  final _userMobileNumberController = TextEditingController();

  // ! Student profile

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
    if (widget.code.toString() != 'null') {
      _userBloc.add(GetProfileUserList(code: widget.email));
      if (widget.guardian == true) {
        _guardianBloc.add(GetProfileGuardianList(code: widget.code));
      }
      if (widget.student == true) {
        _profileBloc.add(GetProfileList(code: widget.code));
      }
    } else {
      _userBloc.add(const GetProfileUserList());
      if (widget.guardian == true) {
        _guardianBloc.add(GetProfileGuardianList());
      }
      if (widget.student == true) {
        _profileBloc.add(GetProfileList());
      }
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
                      'https://${baseUrl}.sekolahmusik.co.id/api/method/logout');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SplashPage()),
                      (route) => false);
                },
                child: const Icon(
                  Icons.logout,
                  color: Color(0xffC9D1D9),
                ),
              ),
        title: Text('My Profile',
            style: sWhiteTextStyle.copyWith(fontWeight: semiBold)),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBasicInfo(),
                (widget.guardian == true)
                    ? _buildGuardianSection()
                    : Container(),
                (widget.student == true) ? _buildStudentSection() : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return BlocBuilder<GetProfileUserBloc, GetProfileUserState>(
      bloc: _userBloc,
      builder: (context, state) {
        if (state is GetProfileUserLoaded) {
          ProfileUser user = state.modelUser;
          _setControllerUser(user.data);
          print('sucec');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileName(user.data),
              const SizedBox(height: 20),
              _buildProfilePicture(user.data),
              const SizedBox(height: 20),
              // ! First Name Field
              Text('First Name', style: fTextColorStyle),
              const SizedBox(height: 5),
              TextFormField(
                style: sWhiteTextStyle,
                controller: _userFirstNameController,
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
                controller: _userLastNameController,
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
                controller: _userMobileNumberController,
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
                  hintText: 'e.x john@example.com',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),

              // ! password
              TextButton(
                  child: Text('Reset my Password',
                      style: sWhiteTextStyle.copyWith(color: sBlueColor)),
                  onPressed: () {}),
            ],
          );
        } else {
          return _loadingSkeleton();
        }
      },
    );
  }

  Widget _buildProfileName(profile) {
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

  Widget _buildProfilePicture(profile) {
    final image;
    if (profile.userImage.length.toString() != '0') {
      if (profile.userImage.toString()[0] == '/') {
        image = 'https://sister.sekolahmusik.co.id${profile.userImage}';
      } else {
        image = profile.userImage.toString();
      }
    } else {
      image = 'assets/images/user.png';
    }

    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: (profile.userImage == null ||
                  profile.userImage.length.toString() == '0')
              ? Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: const DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                )
              : Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 119, 103, 102),
                      image: DecorationImage(
                        image: NetworkImage(image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                ),
        ),
        const SizedBox(width: 15),
        // Text(
        //     (widget.guardian == true)
        //         ? 'This is Guardian Account'
        //         : 'This is Student Account',
            // style: sWhiteTextStyle.copyWith(fontSize: 16))
      ],
    );
  }

  Widget _buildGuardianSection() {
    return BlocBuilder<GetProfileGuardianBloc, GetProfileGuardianState>(
      bloc: _guardianBloc,
      builder: (context, state) {
        if (state is GetProfileGuardianLoaded) {
          ProfileGuardian profile = state.guardianModel;
          _setControllerGuardian(profile.data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // ! title
              Text(
                'Guardian Information',
                style: sWhiteTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 20),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xff272C33),
              ),

              // ! Occupation Field
              Text('Occupation', style: fTextColorStyle),
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
                  hintText: 'e.x john doe',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        } else {
          return Container(
              // child: Text('empty'),
              );
        }
      },
    );
  }

  _buildStudentSection() {
    return BlocBuilder<GetProfileStudentBloc, GetProfileStudentState>(
      bloc: _profileBloc,
      builder: (context, state) {
        if (state is GetProfileLoaded) {
          Profile student = state.profileModel;
          _setControllerStudent(student.data);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),

              // ! title
              Text(
                'Student Information',
                style: sWhiteTextStyle.copyWith(
                    fontWeight: semiBold, fontSize: 20),
              ),
              const Divider(
                thickness: 1,
                color: Color(0xff272C33),
              ),

              // ! Company Field
              Text('Company', style: fTextColorStyle),
              const SizedBox(height: 5),
              TextFormField(
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

              // ! Date Birth Field
              Text('Date Birth', style: fTextColorStyle),
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
                  hintText: 'e.x date birth',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),

              // ! Place Birth Field
              Text('Place Birth', style: fTextColorStyle),
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
                  hintText: 'e.x place birth',
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
                  hintText: 'e.x gender',
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
                  hintText: 'e.x natinallity',
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
                  hintText: 'e.x religion',
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
                  hintText: 'e.x address',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),

              // ! Pincode Field
              Text('Pincode', style: fTextColorStyle),
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
                  hintText: 'e.x pincode',
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
                  hintText: 'e.x city',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),

              // ! Joining Reason Field
              Text('Joining Reason', style: fTextColorStyle),
              const SizedBox(height: 5),
              TextFormField(
                style: sWhiteTextStyle,
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
                  hintText: 'e.x joining reason',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),

              // ! Know From Field
              Text('Know From', style: fTextColorStyle),
              const SizedBox(height: 5),
              TextFormField(
                style: sWhiteTextStyle,
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
                  hintText: 'e.x joining reason',
                  hintStyle: fGreyTextStyle,
                ),
              ),
              const SizedBox(height: 15),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  // ! Skeleton
  Widget _loadingSkeleton() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SkeletonLine(
          style: SkeletonLineStyle(
        height: 20,
        minLength: 120,
        maxLength: 150,
      )),
      const SizedBox(height: 10),
      const SkeletonAvatar(
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
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

  _setControllerUser(user) {
    _userEmailController.text = user.email.toString();

    _userUserNameController.text = user.username.toString();

    _userFirstNameController.text =
        (user.firstName == null) ? '' : user.firstName.toString();

    _userLastNameController.text =
        (user.lastName == null) ? '' : user.lastName.toString();

    _userMobileNumberController.text =
        (user.mobileNo == null) ? '' : user.mobileNo.toString();
  }

  _setControllerGuardian(guardian) {
    _guardianOccupationController.text =
        (guardian.occupation  == null)
            ? ''
            : guardian.occupation.toString();
  }

  _setControllerStudent(student) {
    _companyStudentController.text = (student.company.toString() == 'null')
        ? ''
        : student.company.toString();

    _dateBirthStudentController.text =
        (student.dateOfBirth.toString() == 'null')
            ? ''
            : student.dateOfBirth.toString();

    _placeBirthStudentController.text =
        (student.placeOfBirth.toString() == 'null')
            ? ''
            : student.placeOfBirth.toString();

    _genderStudentController.text =
        (student.gender.toString() == 'null') ? '' : student.gender.toString();

    _nationallityStudentController.text =
        (student.nationality.toString() == 'null')
            ? ''
            : student.nationality.toString();

    _religionStudentController.text = (student.religion.toString() == 'null')
        ? ''
        : student.religion.toString();

    _addressStudentController.text = (student.addressLine1.toString() == 'null')
        ? ''
        : student.addressLine1.toString();

    _pincodeStudentController.text = (student.pincode.toString() == 'null')
        ? ''
        : student.pincode.toString();

    _cityStudentController.text =
        (student.city.toString() == 'null') ? '' : student.city.toString();

    _joiningStudentController.text =
        (student.reasonJoining.toString() == 'null')
            ? ''
            : student.reasonJoining.toString();

    _knowStudentController.text = (student.knowFrom.toString() == 'null')
        ? ''
        : student.knowFrom.toString();
  }
}
