// ignore_for_file: unused_local_variable, unused_catch_stack

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/model/ProfileGuardian-model.dart';

import '../model/ProfileStudent-model.dart';
import '../model/ProfileUser.dart';

class ProfileProvider {
  final dio = Dio();
  var cookieJar = CookieJar();

  final String urlGetProfile =
      'https://njajal.sekolahmusik.co.id/api/resource/Student/';

  Future<Profile> fetchProfileStudent(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');
    var email = pref.getString('user-email');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });

      if (codeDef == null) {
        final getCode = await dio.get(
            'https://njajal.sekolahmusik.co.id/api/resource/Student?filters=[["student_email_id","=","${email}"]]&fields=["*"]');

        var code = getCode.data['data'][0]['name'];

        pref.setString('code', code);

        final request = await dio.get(
            'https://njajal.sekolahmusik.co.id/api/resource/Student/${code}');

        return Profile.fromJson(request.data);
      } else {
        final request = await dio.get(
            'https://njajal.sekolahmusik.co.id/api/resource/Student/${codeDef}');

        return Profile.fromJson(request.data);
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception Occured: $error stackTrace: $stacktrace');
      return Profile.withError('Data not found / Connection Issues');
    }
  }

  Future<ProfileGuardian> fetchProfileGuardian(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');
    var email = pref.getString('guardian-email');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });

      final gege = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Guardian?filters=[["user","=","${email}"]]&fields=["*"]');

      final code = gege.data['data'][0]['name'];

      final getCode = await dio
          .get("https://njajal.sekolahmusik.co.id/api/resource/Guardian");

      if (getCode.statusCode == 200) {
        final request = await dio.get(
            'https://njajal.sekolahmusik.co.id/api/resource/Guardian/${codeDef == null ? code : codeDef}');

        return ProfileGuardian.fromJson(request.data);
      } else {
        return ProfileGuardian.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception Occured: $error stackTrace: $stacktrace');
      return ProfileGuardian.withError('Data not found / Connection Issues');
    }
  }

  Future<ProfileUser> fetchProfileUser(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');
    var userCode;

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });

      var userEmail = pref.getString('user-email');

      if (codeDef == null) {
        final getCode = await dio
            .get("https://njajal.sekolahmusik.co.id/api/resource/User/");

        final request = await dio.get(
            "https://njajal.sekolahmusik.co.id/api/resource/User/${userEmail}");

        return ProfileUser.fromJson(request.data);
        // for (var a = 0; a < getCode.data['data'].length; a++) {
        //   final code = getCode.data['data'][a]['name'];
        //   final request = await dio.get(
        //       'https://njajal.sekolahmusik.co.id/api/resource/User/${code}');
        //   if (request.data['data']['user'] == userEmail) {
        //     userCode = request.data['data']['user'];
        //   }
        // }
      } else {
        final getCode = await dio
            .get("https://njajal.sekolahmusik.co.id/api/resource/User/");

        final request = await dio.get(
            "https://njajal.sekolahmusik.co.id/api/resource/User/${codeDef}");

        return ProfileUser.fromJson(request.data);
      }
      //         if (getCode.statusCode == 200) {

      //           }
      //         } else {
      //           return ProfileUser.withError('Data not found / Connection Issues');
      //         }
      //       } else {
      //         final request = await dio.get(
      //             'https://njajal.sekolahmusik.co.id/api/resource/User/${codeDef}');
      //       }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      return ProfileUser.withError('Data not found / Connection Issues');
    }
  }
}

class NetworkError extends Error {}
