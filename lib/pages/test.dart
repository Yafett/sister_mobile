import 'dart:convert';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:sister_mobile/model/KnowFrom-model.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tess = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SfCalendarTheme(
          data: SfCalendarThemeData(
            backgroundColor: sBlackColor,
            todayHighlightColor: Colors.red,
            headerBackgroundColor: sBlackColor,
            headerTextStyle: sWhiteTextStyle,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _login();
                      },
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _getData();
                      },
                      child: Text('Get Data'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        test();
                      },
                      child: Text('test '),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        logout();
                      },
                      child: Text('logout '),
                    ),
                  ]),
            ),
          )),
    ));
  }

  _login() async {
    var cookis = [];

    final response = await http.post(
        Uri.parse('https://sister.sekolahmusik.co.id/api/method/login'),
        body: {
          'usr': 'administrator',
          'pwd': "admin",
        });

    String? setCookie = response.headers['set-cookie'];

    var asa = response.headers['set-cookie'];

    List<String> result = asa!.split('; ');

    for (var a = 0; a < result.length; a++) {
      print(result[a]);
    }
  }

  _getData() async {
    final response = await http.get(
      Uri.parse('https://sister.sekolahmusik.co.id/api/resource/Fees'),
      headers: {
        'Authorization': "token ee4b62270c9f599:3611d01143a5d46",
      },
    );

    final json = jsonDecode(response.body) as List;
    final enroll = json.map((e) => KnowFrom.fromJson(e)).toList();

    setState(() {
      tess = response.body;
    });
  }

  test() async {
    var dio = Dio();
    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });
    final request =
        await dio.get("https://sister.sekolahmusik.co.id/api/resource/Fees");
    print(request.data);
  }

  logout() async {
    var dio = Dio();

    var cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    final request =
        await dio.get("https://sister.sekolahmusik.co.id/api/resource/Fees");
    print(request.data);
  }
}
