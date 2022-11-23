// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sister_mobile/shared/theme.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  final String urlLogin = '${baseUrl}/method/login';
  final String urlLogout = '${baseUrl}/method/logout';
  final String urlRegister = '${baseUrl}/method/smi.api.registrasi_student';

  login(user, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    var cookieJar = CookieJar();

    final response = await http.post(
      Uri.parse('https://njajal.sekolahmusik.co.id/api/method/login'),
      body: {
        'usr': user,
        'pwd': password,
      },
    );

    prefs.setString('username', user);
    prefs.setString('password', password);

    if (response.statusCode == 200) {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(
        'https://njajal.sekolahmusik.co.id/api/method/login',
        data: {
          'usr': user,
          'pwd': password,
        },
      );

      final getCode =
          await dio.get("https://njajal.sekolahmusik.co.id/api/resource/User");

      final code = getCode.data['data'][0]['name'];

      dio.interceptors.add(CookieManager(cookieJar));
      final identity = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });

      final checking = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Guardian?filters=[["email_address","=","${code}"]]');

      if (checking.data['data'].length > 0) {
        return 'Guardian';
      } else {
        return 'Student';
      }
    } else {
      return 'error';
    }
  }

  register(Map body) async {
    final response = await http.post(Uri.parse('${urlRegister}'), body: body);
  }
}

class NetworkError extends Error {}
