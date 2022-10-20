import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/model/PointReward-model.dart';
import 'package:sister_mobile/model/Schedule-model.dart';

import '../model/Unit-model.dart';

class DataProvider {
  final dio = Dio();
  var cookieJar = CookieJar();

  Future<PointReward> fetchPointReward() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode = await dio
          .get("https://njajal.sekolahmusik.co.id/api/resource/Point Reward");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio.get(
            'https://njajal.sekolahmusik.co.id/api/resource/Point Reward/${code}');

        return PointReward.fromJson(request.data);
      } else {
        return PointReward.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception Occured: $error stackTrace: $stacktrace');

      return PointReward.withError('Data not found / Connection Issues');
    }
  }

  Future<Schedule> fetchSchedule() async {
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
      final getCode = await dio.get(
          "https://sister.sekolahmusik.co.id/api/resource/Course Schedule");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Course Schedule/' +
                code);

        return Schedule.fromJson(request.data);
      } else {
        return Schedule.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception Occured: $error stackTrace: $stacktrace');

      return Schedule.withError('Data not found / Connection Issues');
    }
  }
}

class NetworkError extends Error {}
