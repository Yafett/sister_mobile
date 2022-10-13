import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../model/Unit-model.dart';

class DataProvider {
  final dio = Dio();

  Future<List<Unit>> getUnit() async {
    try {
      var cookieJar = CookieJar();
      dio.interceptors.add(CookieManager(cookieJar));
      final auth = await dio
          .post('https://sister.sekolahmusik.co.id/api/method/login', data: {
        'usr': 'administrator',
        'pwd': 'admin',
      });
      final response = await dio
          .get('https://sister.sekolahmusik.co.id/api/resource/Company');
      final List data = response.data['data'];

      print(data);

      return data.map((e) => Unit.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
