import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/bloc/get-profile-user-bloc/get_profile_user_bloc.dart';
import 'package:sister_mobile/pages/guardians/guardian-home.dart';
import 'package:sister_mobile/pages/students/auth/register-page.dart';
import 'package:sister_mobile/pages/students/student-home.dart';
import 'package:sister_mobile/shared/theme.dart';

import '../../../bloc/login-bloc/login_bloc.dart';
import '../../../widget/fade_page_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
              _buildHomeHeader(),
              _buildHomeBody(),
              _buildLoginButton(context),
              _buildRegisterButton(context),
              _buildTermsText(context)
            ],
          ),
        ),
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

  Widget _buildLoginButton(context) {
    return BlocConsumer<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginSuccess) {
          final role = state.role.toString();

          if (role == 'Guardian') {
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

          print('role : ' + role.toString());
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
              onTap: () {
                _loginBloc.add(
                  Login(
                    _usernameController.text,
                    _passwordController.text,
                  ),
                );
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

  Widget _buildHomeBody() {
    return Column(
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
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildHomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/images/smi-logo-white.png'),
        ),
        const SizedBox(height: 20),
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

  // ! validation

  rolesNavigation() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    Dio dio = Dio();
    var cookieJar = CookieJar();
    var emailId;

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });

    print('reponse : ' + response.data.toString());

    if (response.statusCode == 200) {
      final getCode =
          await dio.get("https://njajal.sekolahmusik.co.id/api/resource/User");

      print('get code : ' + getCode.data.toString());

      var code = getCode.data['data'][0]['name'];

      final request = await dio
          .get('https://njajal.sekolahmusik.co.id/api/resource/User/${code}');

      if (mounted) {
        setState(() {
          emailId = request.data['data']['email'].toString();
        });
      }

      dio.interceptors.add(CookieManager(cookieJar));
      final identity = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });

      final checking = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Guardian?filters=[["email_address","=","${emailId}"]]');

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
}
