// ignore_for_file: unused_element, unused_local_variable

import 'package:http/http.dart' as http;

logout() async {
  final response = await http.post(
      Uri.parse('https://sister.sekolahmusik.co.id/api/method/logout'),
      headers: {
        "Accept": "application/json",
      });
}
