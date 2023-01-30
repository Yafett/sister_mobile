// ignore_for_file: unused_import, prefer_interpolation_to_compose_strings, avoid_print, file_names, unused_field, unused_local_variable, prefer_typing_uninitialized_variables, use_build_context_synchronously, unnecessary_null_comparison, unnecessary_brace_in_string_interps

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sister_mobile/bloc/get-profile-user-bloc/get_profile_user_bloc.dart';
import 'package:sister_mobile/pages/auth/register-page.dart';
import 'package:sister_mobile/pages/auth/student-profile.dart';
import 'package:sister_mobile/pages/guardians/guardian-home.dart';
import 'package:sister_mobile/pages/students/student-home.dart';
import 'package:sister_mobile/shared/theme.dart';

import '../../bloc/login-bloc/login_bloc.dart';
import '../../widget/fade_page_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  final LoginBloc _loginBloc = LoginBloc();
  final _userBloc = GetProfileUserBloc();

  @override
  Widget build(BuildContext context) {
    return _buildLoginPage(context);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildLoginPage(context) {
    return Scaffold(
      backgroundColor: const Color(0xffE8E8E8),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLoginHeader(),
              _buildLoginBody(),
              _buildLoginButton(context),
              _buildRegisterButton(context),
              _buildTermsText(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              fit: BoxFit.cover,
              width: 210,
              height: 110,
              image: AssetImage('assets/images/title.png'), 
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'Proceed with your\n',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              ),
              TextSpan(
                text: 'Login',
                style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 120),
      ],
    );
  }

  Widget _buildLoginBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextFormField(
          controller: _usernameController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.person_outlined),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const UnderlineInputBorder(),
            focusColor: Colors.black,
            hintText: 'Email',
            hintStyle: GoogleFonts.openSans(),
          ),
          onSaved: (String? value) {},
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.lock_outline),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            border: const UnderlineInputBorder(),
            focusColor: Colors.black,
            hintText: 'Password',
            hintStyle: GoogleFonts.openSans(),
          ),
        ),
        _buildForgetPasswordButton(),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildLoginButton(context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          final role = state.role.toString();
          print('room : ' + role.toString());
          if (role == 'Guardian Student') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => GuardianHomePage(
                          isStudent: true,
                        )),
                (route) => false);
          } else if (role == 'Guardian') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => GuardianHomePage()),
                (route) => false);
          } else if (role == 'Student') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => StudentHomePage()),
                (route) => false);
          } else if (role == 'Staff') {
            print('btoom');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => StudentProfilePage(
                          back: false,
                        )),
                (route) => false);
          } else {
            MotionToast(
              height: 50,
              width: 300,
              primaryColor: sRedColor,
              description: Text(
                'Wrong Credentials',
                style: sRedTextStyle.copyWith(fontWeight: semiBold),
              ),
              icon: Icons.warning_amber,
              animationCurve: Curves.bounceIn,
            ).show(context);
          }
        } else if (state is LoginError) {
          MotionToast(
            height: 50,
            width: 300,
            primaryColor: sRedColor,
            description: Text(
              state.message.toString(),
              style: sRedTextStyle.copyWith(fontWeight: semiBold),
            ),
            icon: Icons.warning_amber,
            animationCurve: Curves.bounceIn,
          ).show(context);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return Material(
            color: const Color(0xffE22426),
            child: InkWell(
              splashColor: Colors.grey,
              onTap: () {},
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(
                    color: sWhiteColor,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Material(
            color: const Color(0xffE22426),
            child: InkWell(
              splashColor: Colors.grey,
              onTap: () async {
                if (_usernameController.text.length == 0 ||
                    _passwordController.text.length == 0) {
                  MotionToast(
                    height: 70,
                    width: 300,
                    primaryColor: sRedColor,
                    description: Text(
                      "Field Musn't be empty",
                      style: sRedTextStyle.copyWith(fontWeight: semiBold),
                    ),
                    icon: Icons.warning_amber,
                    animationCurve: Curves.bounceIn,
                  ).show(context);
                } else {
                  _loginBloc.add(
                    Login(
                      _usernameController.text,
                      _passwordController.text,
                    ),
                  );
                }
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                    child: Text(
                  'Login',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                )),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildRegisterButton(context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        Material(
          color: const Color(0xffE8E8E8),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () {
              Navigator.of(context).push(FadePageRoute(const RegisterPage()));
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xffE22426))),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                  child: Text(
                'Register',
                style: GoogleFonts.openSans(
                  color: const Color(0xffE22426),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgetPasswordButton() {
    return TextButton(
      onPressed: () {
        bottomSheet();
      },
      child: Text(
        'forgot password?',
        style: sGreyTextStyle,
      ),
    );
  }

  Widget _buildTermsText(context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Terms and Conditions',
            style: GoogleFonts.openSans(
              color: const Color(0xffE22426),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Privacy and Policy',
            style: GoogleFonts.openSans(
              color: const Color(0xffE22426),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ! validation
  rolesNavigation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Dio dio = Dio();
    var cookieJar = CookieJar();
    var emailId;

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });

    print('reponse : ' + response.data.toString());

    if (response.statusCode == 200) {
      final getCode =
          await dio.get("https://sister.sekolahmusik.co.id/api/resource/User");

      print('get code : ' + getCode.data.toString());

      var code = getCode.data['data'][0]['name'];

      final request = await dio
          .get('https://sister.sekolahmusik.co.id/api/resource/User/${code}');

      if (mounted) {
        setState(() {
          emailId = request.data['data']['email'].toString();
        });
      }

      dio.interceptors.add(CookieManager(cookieJar));
      final identity = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });

      final checking = await dio.get(
          'https://sister.sekolahmusik.co.id/api/resource/Guardian?filters=[["email_address","=","${emailId}"]]');

      print(checking.data['data'].length);

      if (checking.data['data'].length > 0) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => GuardianHomePage()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => StudentHomePage()),
            (route) => false);
      }
    } else {
      MotionToast(
        height: 50,
        width: 300,
        primaryColor: sRedColor,
        description: Text(
          'Wrong Username or Password',
          style: sRedTextStyle.copyWith(fontWeight: semiBold),
        ),
        icon: Icons.warning_amber,
        animationCurve: Curves.bounceIn,
      ).show(context);
    }
  }

  // ! modal
  bottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4), topRight: Radius.circular(4)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Email Address';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your Email Here',
                  ),
                ),
                const SizedBox(height: 20),
                Material(
                  color: const Color(0xffE22426),
                  child: InkWell(
                    splashColor: Colors.grey,
                    onTap: () async {
                      final dio = Dio();

                      if (_emailController.text == null ||
                          _emailController.text == '') {
                        Navigator.pop(context);
                        MotionToast(
                          height: 50,
                          width: 300,
                          primaryColor: sRedColor,
                          description: Text(
                            'Enter your Email First!',
                            style: sRedTextStyle.copyWith(fontWeight: semiBold),
                          ),
                          icon: Icons.warning_amber,
                          animationCurve: Curves.bounceIn,
                        ).show(context);
                        _emailController.text = '';
                      } else if (_emailController.text.contains('@') == false ||
                          _emailController.text.contains('.') == false) {
                        Navigator.pop(context);
                        MotionToast(
                          height: 50,
                          width: 300,
                          primaryColor: sRedColor,
                          description: Text(
                            'You put wrong Email Format!',
                            style: sRedTextStyle.copyWith(fontWeight: semiBold),
                          ),
                          icon: Icons.warning_amber,
                          animationCurve: Curves.bounceIn,
                        ).show(context);
                        _emailController.text = '';
                      } else {
                        final response = await dio.get(
                          'https://sister.sekolahmusik.co.id/api/method/frappe.core.doctype.user.user.reset_password?user=${_emailController.text}',
                        );

                        if (response.data['message'] == null) {
                          Navigator.pop(context);
                          MotionToast.info(
                            height: 50,
                            width: 300,
                            // primaryColor: sGreenColor,
                            description: Text(
                              'Check your Email for Reset your Password',
                              style: sGreyTextStyle.copyWith(
                                  fontWeight: semiBold,
                                  color: Colors.deepPurple),
                            ),
                            // icon: Icons.email,
                            animationCurve: Curves.bounceIn,
                          ).show(context);
                        } else {
                          Navigator.pop(context);
                          MotionToast(
                            height: 50,
                            width: 300,
                            primaryColor: sRedColor,
                            description: Text(
                              'Email not Found!',
                              style:
                                  sRedTextStyle.copyWith(fontWeight: semiBold),
                            ),
                            icon: Icons.warning_amber,
                            animationCurve: Curves.bounceIn,
                          ).show(context);
                        }
                      }

                      // ! textfield empty =   'Enter your Email First!'
                      // ! not contain '@' and '.' = 'You put wrong Email Format!'
                      // ! user not found =  'Email not Found!'
                      // * user found = 'Check your Email for Reset your Password'

                      _emailController.text = '';
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Center(
                          child: Text(
                        'Send',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
