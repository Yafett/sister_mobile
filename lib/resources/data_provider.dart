// ignore_for_file: unused_local_variable

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/model/Attendance-model.dart';
import 'package:sister_mobile/model/Enrollment-model.dart';
import 'package:sister_mobile/model/Payment-model.dart';
import 'package:sister_mobile/model/PointReward-model.dart';
import 'package:sister_mobile/model/Schedule-model.dart';

class DataProvider {
  final dio = Dio();
  var cookieJar = CookieJar();

  String urlLogin = "https://njajal.sekolahmusik.co.id/api/method/login";
  String urlPointReward =
      "https://njajal.sekolahmusik.co.id/api/resource/Point Reward";
  String urlSchedule =
      'https://njajal.sekolahmusik.co.id/api/method/smi.api.get_student_course_schedule';

  Future<PointReward> fetchPointReward(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(urlLogin, data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final getCode = await dio.get(urlPointReward);

      if (getCode.statusCode == 200) {
        var code = getCode.data['data'][0]['name'];
        final request = await dio
            .get('${urlPointReward}/${codeDef == null ? code : codeDef}');

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

  Future<Schedule> fetchSchedule(code) async {
    // 0062-t1-000001
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(urlLogin, data: {
        'usr': user,
        'pwd': pass,
      });

      final request = await dio.post(
        urlSchedule,
        data: {
          'stud': code,
        },
      );

      if (request.statusCode == 200) {
        pref.setString(
            'schedule-length', request.data['message'].length.toString());

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
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });
      final getCode = await dio
          .get('https://njajal.sekolahmusik.co.id/api/resource/Student/');

      final request = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Student Attendance?filters=[["student","=","${getCode.data['data'][0]['name']}"]]&fields=["*"]');

      if (request.statusCode == 200) {
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
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });
      final getCode = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Program Enrollment/');

      final request = await dio.get(
          'https://njajal.sekolahmusik.co.id/api/resource/Program Enrollment/${getCode.data['data'][0]['name']}');

      if (request.statusCode == 200) {
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

  Future<Payment> fetchFees(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');
    var feesList = [];
    var unpaidFeesList = [];

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://njajal.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
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
          feesList.add(request.data['data']);
          if (request.data['data']['status'].toString() == 'Unpaid') {
            unpaidFeesList.add(request.data['data']);
          }
        }

        pref.setString('payment-total', feesList.length.toString());
        pref.setString('payment-length', unpaidFeesList.length.toString());

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
}

class NetworkError extends Error {}
