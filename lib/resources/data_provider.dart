import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/model/Attendance-model.dart';
import 'package:sister_mobile/model/Enrollment-model.dart';
import 'package:sister_mobile/model/Payment-model.dart';
import 'package:sister_mobile/model/PointReward-model.dart';
import 'package:sister_mobile/model/Schedule-model.dart';
import 'package:sister_mobile/model/Test-model.dart';

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
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode = await dio
          .get("https://sister.sekolahmusik.co.id/api/resource/Point Reward");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Point Reward/${code}');

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

  Future<Schedule> fetchSchedule({stud}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'fabian@smi.com',
        'pwd': 'admin123',
      });

      final request = await dio.post(
        'https://njajal.sekolahmusik.co.id/api/method/smi.api.get_student_course_schedule',
        data: {
          if (stud != null)
            {
              'stud': '${stud}',
            }
          else
            {
              'stud': '0062-S-PA-000332',
            }
        },
      );

      if (request.statusCode == 200) {
        pref.setString('schedule-length', 1.toString());

        var length = pref.getString('schedule-length');

        return Schedule.fromJson(request.data);
      } else {
        return Schedule.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Schedule Data Exception Occured: $error stackTrace: $stacktrace');

      return Schedule.withError('Data not found / Connection Issues');
    }
  }

  Future<Attendance> fetchAttendance() async {
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
          "https://sister.sekolahmusik.co.id/api/resource/Student Attendance");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio.get(
          'https://sister.sekolahmusik.co.id/api/resource/Student Attendance/' +
              code,
        );

        pref.setString('attendance-length', code.length.toString());

        var length = pref.getString('attendance-length');

        print(request.data);

        return Attendance.fromJson(request.data);
      } else {
        return Attendance.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Exception Occured: $error stackTrace: $stacktrace');

      return Attendance.withError('Data not found / Connection Issues');
    }
  }

  Future<Enrollment> fetchEnrollment() async {
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
          "https://sister.sekolahmusik.co.id/api/resource/Program Enrollment");

      print(getCode.data['data'].length.toString());

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Program Enrollment/${code}');

        return Enrollment.fromJson(request.data);
      } else {
        return Enrollment.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Fees Exception Occured: $error stackTrace: $stacktrace');

      return Enrollment.withError('Data not found / Connection Issues');
    }
  }

  Future<Payment> fetchFees({code}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');
    var feesList = [];

    print('code : ' + code.toString());

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode =
          await dio.get("https://njajal.sekolahmusik.co.id/api/resource/Fees");

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio
            .get('https://njajal.sekolahmusik.co.id/api/resource/Fees/${code}');

        for (var a = 0; a < getCode.data['data'].length; a++) {
          var code = getCode.data['data'][a]['name'];
          final request = await dio.get(
              'https://njajal.sekolahmusik.co.id/api/resource/Fees/${code}');

          if (request.data['data']['status'].toString() == 'Unpaid') {
            feesList.add(request.data['data']);
          }
        }

        pref.setString('payment-length', feesList.length.toString());

        return Payment.fromJson(request.data);
      } else {
        return Payment.withError('Data not found / Connection Issues');
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Fees Exception Occured: $error stackTrace: $stacktrace');

      return Payment.withError('Data not found / Connection Issues');
    }
  }

  // Future<List<Testing>> testing({code}) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();

  //   print('code : ' + code.toString());

  //   try {
  //     dio.interceptors.add(CookieManager(cookieJar));
  //     final response = await dio
  //         .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
  //       'usr': 'administrator',
  //       'pwd': 'admin',
  //     });

  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body) as List;
  //       final news = json.map((e) => News.fromJson(e)).toList();
  //       return news;
  //     } else {
  //       throw Exception("Failed to load News");
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }

  // try {
  //   dio.interceptors.add(CookieManager(cookieJar));
  //   final response = await dio
  //       .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
  //     'usr': 'administrator',
  //     'pwd': 'admin',
  //   });
  //   final getCode =
  //       await dio.get("https://njajal.sekolahmusik.co.id/api/resource/Fees");

  //     for (var a = 0; a < getCode.data['data'].length; a++) {
  //       var code = getCode.data['data'][a]['name'];
  //       final request = await dio.get(
  //           'https://njajal.sekolahmusik.co.id/api/resource/Fees/${code}');

  //       if (request.data['data']['status'].toString() == 'Unpaid') {
  //         feesList.add(request.data['data']);
  //       }
  //     }

  //     return Testing.fromJson(request.data);
  //   } else {
  //     return Testing.withError('Data not found / Connection Issues');
  //   }
  // } catch (error, stacktrace) {
  //   // ignore: avoid_print
  //   print('Fees Exception Occured: $error stackTrace: $stacktrace');

  //   return Testing.withError('Data not found / Connection Issues');
  // }
  // }

  fetchTest() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode =
          await dio.get("https://sister.sekolahmusik.co.id/api/resource/Fees");

      for (var a = 0; a < getCode.data['data'].length; a++) {
        var code = getCode.data['data'][a]['name'];
        final request = await dio
            .get('https://sister.sekolahmusik.co.id/api/resource/Fees/${code}');

        return Payment.fromJson(request.data);
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Fees Exception Occured: $error stackTrace: $stacktrace');

      return Payment.withError('Data not found / Connection Issues');
    }
  }
}

class NetworkError extends Error {}
