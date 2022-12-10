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

  String urlLogin = "https://sister.sekolahmusik.co.id/api/method/login";
  String urlPointReward =
      "https://sister.sekolahmusik.co.id/api/resource/Point Reward";
  String urlSchedule =
      'https://sister.sekolahmusik.co.id/api/method/smi.api.get_student_course_schedule';

  Future<PointReward> fetchPointReward(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');
    var listPoint = [];

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(urlLogin, data: {
        'usr': user,
        'pwd': pass,
      });

      if (codeDef == null) {
        listPoint.clear();
        final getCode = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Point Reward/');
        if (getCode.statusCode == 200) {
          for (var a = 0; a < getCode.data['data'].length; a++) {
            final getPoint = await dio.get(
                'https://sister.sekolahmusik.co.id/api/resource/Point Reward/${getCode.data['data'][a]['name']}');

            listPoint
                .add(double.parse(getPoint.data['data']['point'].toString()));
          }

          if (listPoint.length > 0) {
            var sum = listPoint.reduce((a, b) => a + b);

            pref.setString('point-length', sum.toString());
          } else {
            pref.setString('point-length', '0');
          }

          final request = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/Point Reward/${getCode.data['data'][0]['name']}');

          return PointReward.fromJson(request.data);
        } else {
          return PointReward.withError('Data not found / Connection Issues');
        }
      } else {
        final getCode = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Point Reward?filters=[["student","=","${codeDef}"]]&fields=["*"]');

        for (var a = 0; a < getCode.data['data'].length; a++) {
          final getPoint = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/Point Reward/${getCode.data['data'][a]['name']}');
          listPoint.clear();

          listPoint
              .add(double.parse(getPoint.data['data']['point'].toString()));
        }

        if (listPoint.length > 0) {
          var sum = listPoint.reduce((a, b) => a + b);

          pref.setString('point-length', sum.toString());
        } else {
          pref.setString('point-length', '0');
        }

        final code = getCode.data['data'][0]['name'];

        final request = await dio.get(
            'https://sister.sekol ahmusik.co.id/api/resource/Point Reward/${code}');

        return PointReward.fromJson(request.data);
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
    var listSchedule = [];

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio.post(urlLogin, data: {
        'usr': user,
        'pwd': pass,
      });

      if (code == null) {
        final getCode = await dio
            .get('https://sister.sekolahmusik.co.id/api/resource/Student/');

        final code = getCode.data['data'][0]['name'];

        final request = await dio.post(urlSchedule, data: {
          'stud': code,
        });

        pref.setString(
            'schedule-length', request.data['message'].length.toString());

        print('list : ' + listSchedule.toString());

        return Schedule.fromJson(request.data);
      } else {
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
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      // print('Schedule Data Exception Occured: $error stackTrace: $stacktrace');

      return Schedule.withError('Data not found / Connection Issues');
    }
  }

  Future<Attendance> fetchAttendance(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });

      if (codeDef == null) {
        print('student');
        final getCode = await dio
            .get('https://sister.sekolahmusik.co.id/api/resource/Student/');

        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Student Attendance?filters=[["student","=","${getCode.data['data'][0]['name']}"]]&fields=["*"]');

        if (request.statusCode == 200) {
          return Attendance.fromJson(request.data);
        } else {
          return Attendance.withError('Data not found / Connection Issues');
        }
      } else {
        print('guardian');
        final getCode = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Student Attendance?filters=[["student","=","${codeDef}"]]&fields=["*"]');

        final code = getCode.data['data'][0]['name'];

        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Program Enrollment/${code}');

        return Attendance.fromJson(request.data);
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      // print('Exception Occured: $error stackTrace: $stacktrace');

      return Attendance.withError('Data not found / Connection Issues');
    }
  }

  Future<Enrollment> fetchEnrollment(codeDef) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    try {
      dio.interceptors.add(CookieManager(cookieJar));
      final response = await dio
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });

      if (codeDef == null) {
        final getCode = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Program Enrollment/');

        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Program Enrollment/${getCode.data['data'][0]['name']}');

        if (request.statusCode == 200) {
          return Enrollment.fromJson(request.data);
        } else {
          return Enrollment.withError('Data not found / Connection Issues');
        }
      } else {
        final getCode = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Program Enrollment?filters=[["student","=","${codeDef}"]]&fields=["*"]');

        final code = getCode.data['data'][0]['name'];

        final request = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Program Enrollment/${code}');

        return Enrollment.fromJson(request.data);
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
          .post("https://sister.sekolahmusik.co.id/api/method/login", data: {
        'usr': user,
        'pwd': pass,
      });

      if (codeDef.toString() == null.toString()) {
        final getCode = await dio
            .get("https://sister.sekolahmusik.co.id/api/resource/Fees");

        var code = getCode.data['data'][0]['name'];

        final request = await dio
            .get('https://sister.sekolahmusik.co.id/api/resource/Fees/${code}');

        for (var a = 0; a < getCode.data['data'].length; a++) {
          var code = getCode.data['data'][a]['name'];
          final request = await dio.get(
              'https://sister.sekolahmusik.co.id/api/resource/Fees/${code}');
          feesList.add(request.data['data']);
          if (request.data['data']['status'].toString() == 'Unpaid') {
            unpaidFeesList.add(request.data['data']);
          }
        }
        pref.setString('payment-total', feesList.length.toString());
        pref.setString('payment-length', unpaidFeesList.length.toString());

        return Payment.fromJson(request.data);
      } else {
        final getCode = await dio.get(
            'https://sister.sekolahmusik.co.id/api/resource/Fees?filters=[["student","=","${codeDef}"]]&fields=["*"]');

        for (var a = 0; a < getCode.data['data'].length; a++) {
          feesList.add(getCode.data['data']);
          if (getCode.data['data'][a]['status'].toString() == 'Unpaid') {
            unpaidFeesList.add(getCode.data['data']);
          }
        }

        pref.setString('payment-total', feesList.length.toString());
        pref.setString('payment-length', unpaidFeesList.length.toString());

        print(getCode.data['data'].toString());

        return Payment.fromJson(getCode.data['data'][0]);
      }
    } catch (error, stacktrace) {
      // ignore: avoid_print
      print('Fees Exception Occured: $error stackTrace: $stacktrace');

      return Payment.withError('Data not found / Connection Issues');
    }
  }
}

class NetworkError extends Error {}
