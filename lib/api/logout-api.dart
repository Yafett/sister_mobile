// ignore_for_file: unused_element, unused_local_variable, file_names

import 'package:http/http.dart' as http;
import 'package:sister_mobile/shared/theme.dart';

logout() async {
  final response = await http.post(
      Uri.parse('https://${baseUrl}.sekolahmusik.co.id/api/method/logout'),
      headers: {
        "Accept": "application/json",
      });
}
