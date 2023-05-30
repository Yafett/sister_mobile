import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sister_mobile/shared/theme.dart';
import 'package:sister_mobile/widget/no_scroll_waves.dart';
import 'package:sister_mobile/widget/timeline.dart';
import 'package:intl/intl.dart';

class LogviewPage extends StatefulWidget {
  var attendance;

  LogviewPage({super.key, required this.attendance});

  @override
  State<LogviewPage> createState() => _LogviewPageState();
}

class _LogviewPageState extends State<LogviewPage> {
  var logviewList = [];
  final dio = Dio();
  var cookieJar = CookieJar();

  var totalLogview;

  @override
  void initState() {
    super.initState();
    _fetchLogview();
  }

  @override
  Widget build(BuildContext context) {
    return _buildLogviewPage();
  }

  _buildLogviewPage() {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 29, 37),
      appBar: AppBar(
        elevation: 15,
        centerTitle: true,
        shadowColor: sBlackColor,
        backgroundColor: Color.fromARGB(255, 23, 29, 37),
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Logview Details',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 100,
                width: MediaQuery.sizeOf(context).width,
                color: sGreyColor,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${totalLogview == null ? '0' : totalLogview} Views',
                        style: sWhiteTextStyle.copyWith(
                            fontSize: 16, fontWeight: semiBold),
                      ),
                      Text(widget.attendance,
                          style: sWhiteTextStyle.copyWith()),
                    ]),
              ),
              SizedBox(height: 10),
              Timeline(
                lineColor: sGreyColor,
                children: <Widget>[
                  ...logviewList.map((item) {
                    DateTime dt = DateTime.parse(item['data']['creation']);

                    String formattedDate =
                        DateFormat('kk:mm - dd MMM yyyy').format(dt);

                    return Container(
                      color: sGreyColor,
                      child: Text(
                        '${item['data']['viewed_by']} • ${formattedDate.toString()}',
                        style: sWhiteTextStyle,
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    );
                  }).toList(),
                ],
                indicators: <Widget>[
                  ...logviewList.map((item) {
                    return Icon(
                      Icons.circle_outlined,
                      color: sGreyColor,
                    );
                  }).toList(),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  _fetchLogview() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var user = pref.getString("username");
    var pass = pref.getString('password');

    var viewlogCode = [];
    var viewlogList = [];

    dio.interceptors.add(CookieManager(cookieJar));
    final response = await dio
        .post("https://${baseUrl}.sekolahmusik.co.id/api/method/login", data: {
      'usr': 'administrator',
      'pwd': 'admin',
    });

    var getViewlog = await dio
        .get('https://njajal.sekolahmusik.co.id/api/resource/View Log/');

    for (var i = 0; i < getViewlog.data['data'].length; i++) {
      viewlogCode.add(getViewlog.data['data'][i]);
    }

    for (var i = 0; i < viewlogCode.length; i++) {
      final response = await dio.get(
          'https://${baseUrl}.sekolahmusik.co.id/api/resource/View Log/${viewlogCode[i]['name']}');

      if (response.data['data']['reference_name'].toString() ==
          widget.attendance) {
        if (mounted) {
          setState(() {
            logviewList.add(response.data);
          });
        }
      }
    }

    if (mounted) {
      setState(() {
        totalLogview = logviewList.length.toString();
      });
    }
  }
}
