// ignore_for_file: unused_local_variable

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
      'https://sister.sekolahmusik.co.id/api/resource/Student/';

  Future<Profile> fetchProfileStudent() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode = await dio
          .get("https://sister.sekolahmusik.co.id/api/resource/Student");
      var code = getCode.data['data'][0]['name'];

      final request = await dio.get(
          'https://sister.sekolahmusik.co.id/api/resource/Student/' + code);

      return Profile.fromJson(request.data);
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception Occured: $error stackTrace: $stacktrace');
      return Profile.withError('Data not found / Connection Issues');
    }
  }

  Future<ProfileGuardian> fetchProfileGuardian() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode = await dio
          .get("https://sister.sekolahmusik.co.id/api/resource/Guardian");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Guardian/' + code);

        return ProfileGuardian.fromJson(request.data);
      } else {
        return ProfileGuardian.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      // print('Exception Occured: $error stackTrace: $stacktrace');
      return ProfileGuardian.withError('Data not found / Connection Issues');
    }
  }

  Future<ProfileUser> fetchProfileUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode =
          await dio.get("https://sister.sekolahmusik.co.id/api/resource/User");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio
            .get('https://sister.sekolahmusik.co.id/api/resource/User/' + code);

        return ProfileUser.fromJson(request.data);
      } else {
        return ProfileUser.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      return ProfileUser.withError('Data not found / Connection Issues');
    }
  }
}

class NetworkError extends Error {}
