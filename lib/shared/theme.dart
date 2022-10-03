import 'dart:convert';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sister_mobile/pages/register-page.dart';

import '../api/logout-api.dart';
import '../bloc/login-bloc/login_bloc.dart';
import '../widget/custom_page_route.dart';
import '../widget/fade_page_route.dart';

part '../pages/splash-page.dart';
part '../pages/login-page.dart';

Color kBlueColor = const Color(0xff1F98A8);
Color kWhiteColor = Colors.white;
Color kBlackColor = const Color(0xff2C2C2C);
Color sWhiteColor = Color(0xffC9D1D9);
Color sGreyColor = Color(0xff272C33);
// ! first Section
TextStyle fWhiteTextStyle = GoogleFonts.openSans(color: Colors.white);
TextStyle fBlackTextStyle = GoogleFonts.openSans(color: Colors.black);
TextStyle fGreyTextStyle = GoogleFonts.openSans(color: Colors.grey);
TextStyle fTextColorStyle =
    GoogleFonts.openSans(color: const Color(0xff8E8E8E));
TextStyle fTermsColorStyle =
    GoogleFonts.openSans(color: const Color(0xff616161));

// ! second Section
TextStyle sWhiteTextStyle = GoogleFonts.openSans(color: Color(0xffC9D1D9));
TextStyle sBlackTextStyle = GoogleFonts.openSans(color: Color(0xff0D1117));
TextStyle sGreyTextStyle = GoogleFonts.openSans(color: Color(0xff6B7178));
TextStyle sRedTextStyle = GoogleFonts.openSans(color: Color(0xffD15151));

BorderRadius radiusNormal = BorderRadius.circular(12);

FontWeight extraLight = FontWeight.w100;
FontWeight light = FontWeight.w200;
FontWeight regular = FontWeight.w300;
FontWeight medium = FontWeight.w400;
FontWeight semi = FontWeight.w500;
FontWeight semiBold = FontWeight.bold;
