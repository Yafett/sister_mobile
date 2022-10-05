import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sister_mobile/pages/students/payment/student-payment-detail.dart';
import 'package:sister_mobile/pages/students/payment/student-payment-help.dart';
import 'package:sister_mobile/pages/students/point/student-point-detail.dart';
import 'package:sister_mobile/pages/students/point/student-point-help.dart';
import 'package:sister_mobile/pages/students/point/student-point.dart';
import 'package:sister_mobile/pages/students/schedule/student-schedule-help.dart';
import 'package:sister_mobile/pages/students/schedule/student-schedule.dart';
import 'package:sister_mobile/pages/students/student-home.dart';
import 'package:sister_mobile/pages/students/payment/student-payment.dart';
import 'package:sister_mobile/pages/terms-page.dart';
import 'package:sister_mobile/pages/test.dart';

import '../shared/theme.dart';
import 'pages/register-page.dart';

void main() {
  // add these lines
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // run app
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const StudentHomePage(),
        '/home': (context) => const LoginPage(),
        '/terms': (context) => const TermPage(),
        '/student-payment': (context) => const StudentPaymentPage(),
        '/student-payment-help': (context) => const StudentPaymentHelpPage(),
        '/student-payment-detail': (context) =>
            const StudentPaymentDetailPage(),
        '/student-point': (context) => const StudentPointPage(),
        '/student-point-help': (context) => const StudentPointHelpPage(),
        '/student-point-detail': (context) => const StudentPointDetailPage(),
        '/student-schedule': (context) => const StudentSchedulePage(),
        '/student-schedule-help': (context) => const StudentScheduleHelpPage(),
      },
    );
  }
}
