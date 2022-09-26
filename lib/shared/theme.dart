import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:sister_mobile/pages/register-page.dart';

import '../widget/custom_page_route.dart';
import '../widget/fade_page_route.dart';

part '../pages/splash-page.dart';
part '../pages/home-page.dart';

Color kBlueColor = Color(0xff1F98A8);
Color kWhiteColor = Colors.white;
Color kBlackColor = Color(0xff2C2C2C);

// ! first Section
TextStyle fWhiteTextStyle = GoogleFonts.openSans(color: Colors.white);
TextStyle fBlackTextStyle = GoogleFonts.openSans(color: Colors.black); 
TextStyle fGreyTextStyle = GoogleFonts.openSans(color: Colors.grey); 
TextStyle fTextColorStyle = GoogleFonts.openSans(color: Color(0xff8E8E8E)); 

BorderRadius radiusNormal = BorderRadius.circular(12);

FontWeight extraLight = FontWeight.w100;
FontWeight light = FontWeight.w200;
FontWeight regular = FontWeight.w300;
FontWeight medium = FontWeight.w400;
FontWeight semi = FontWeight.w500;
FontWeight semiBold = FontWeight.bold;
