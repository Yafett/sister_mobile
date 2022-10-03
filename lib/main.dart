import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sister_mobile/pages/students/student-home.dart';
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
        '/terms': ((context) => const TermPage()),
      },
    );
  }
}
