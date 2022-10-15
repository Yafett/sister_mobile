// ignore_for_file: unused_local_variable

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Profile-model.dart';

class ProfileProvider {
  final dio = Dio();
  var cookieJar = CookieJar();

  final String urlGetProfile =
      'https://sister.sekolahmusik.co.id/api/resource/Student/';

  Future<Profile> fetchProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'yafhet_rama',
        'pwd': 'yafhet',
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
}

class NetworkError extends Error {}
