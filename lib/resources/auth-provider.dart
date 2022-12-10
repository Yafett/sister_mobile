// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sister_mobile/shared/theme.dart';

class AuthProvider {
  final String urlLogin = '${baseUrl}/method/login';
  final String urlLogout = '${baseUrl}/method/logout';
  final String urlRegister = '${baseUrl}/method/smi.api.registrasi_student';

  login(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Dio dio = Dio();
    var cookieJar = CookieJar();
    var listEmail = [];
    var listUser = [];

    var user = username;
    var pass = password;

    // var user = 'tatata@smi.com';
    // var pass = 'demo';

    // var user = 'yafhet_rama';
    // var pass = 'yafhet';

    // var user = 'ekamulyanto@smi.com';
    // var pass = 'demo';

    final verify = await http.post(
        Uri.parse('https://sister.sekolahmusik.co.id/api/method/login'),
        body: {
          'usr': user,
          'pwd': pass,
        });

    if (verify.statusCode == 200) {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(
        'https://sister.sekolahmusik.co.id/api/method/login',
        data: {
          'usr': user,
          'pwd': pass,
        },
      );

      prefs.setString('username', user);
      prefs.setString('password', pass);

      if (response.statusCode == 200) {
        if (user.toString().contains('@')) {
          final getCode = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/User?filters=[["email","=","${user}"]]&fields=["*"]');

          final code = getCode.data['data'][0]['name'];

          final getUser = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/User/${code}');

          for (var a = 0; a < getUser.data['data']['roles'].length; a++) {
            print(getUser.data['data']['roles'][a]['role'].toString());

            listUser.add(getUser.data['data']['roles'][a]['role'].toString());
          }

          print(listUser.toString());
        } else {
          final getCode = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/User?filters=[["username","=","${user}"]]&fields=["*"]');

          final code = getCode.data['data'][0]['name'];

          user = code;

          final getUser = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/User/${code}');
          for (var a = 0; a < getUser.data['data']['roles'].length; a++) {
            print(getUser.data['data']['roles'][a]['role'].toString());

            listUser.add(getUser.data['data']['roles'][a]['role'].toString());
          }
        }

        prefs.setString('user-email', user);

        if (listUser.contains('Student Guardian')) {
          print('lily');
          final getGuardianCode = await dio
              .get('https://sister.sekolahmusik.co.id/api/resource/Guardian/');

          for (var a = 0; a < getGuardianCode.data['data'].length; a++) {
            final getGuardian = await dio.get(
                'https://sister.sekolahmusik.co.id/api/resource/Guardian/${getGuardianCode.data['data'][a]['name'].toString()}');

            if (getGuardian.data['data']['user'].toString() == user) {
              print('im Guardian');
              return 'Guardian';
            }
          }
        } else if (listUser.contains('Student')) {
          print('eve');
          final getStudentCode = await dio
              .get('https://sister.sekolahmusik.co.id/api/resource/Student/');

          for (var a = 0; a < getStudentCode.data['data'].length; a++) {
            final getStudent = await dio.get(
                'https://sister.sekolahmusik.co.id/api/resource/Student/${getStudentCode.data['data'][a]['name'].toString()}');

            if (getStudent.data['data']['user'].toString() == user) {
              print('im Student');
              return 'Student';
            }
          }
        }
        if (listUser.contains('Instructor') || listUser.contains('Employee')) {
          print('im Staff');
          return 'Staff';
        } else {
          print('ursus');
          final getUserCode = await dio
              .get('https://sister.sekolahmusik.co.id/api/resource/User/');

          for (var a = 0; a < getUserCode.data['data'].length; a++) {
            final getUser = await dio.get(
                'https://sister.sekolahmusik.co.id/api/resource/User/${getUserCode.data['data'][a]['name'].toString()}');

            print(user.toString());
            if (getUser.data['data']['user'].toString() == user) {
              return 'Customer';
            }
          }
        }
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
