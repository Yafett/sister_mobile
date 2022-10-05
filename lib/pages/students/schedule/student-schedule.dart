import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sister_mobile/pages/students/payment/student-payment.dart';
import 'package:sister_mobile/pages/students/student-home.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../shared/theme.dart';

class StudentSchedulePage extends StatefulWidget {
  const StudentSchedulePage({Key? key}) : super(key: key);

  @override
  State<StudentSchedulePage> createState() => _StudentSchedulePageState();
}

class _StudentSchedulePageState extends State<StudentSchedulePage> {
  @override
  Widget build(BuildContext context) {
    return _buildSchedulePage();
  }

  Widget _buildSchedulePage() {
    return Scaffold(
        // backgroundColor: sBlackColor,
        appBar: AppBar(
          backgroundColor: sBlackColor,
          leading: const BackButton(color: Color(0xffC9D1D9)),
          title: Text('Point Reward',
              style: sWhiteTextStyle.copyWith(fontWeight: semiBold)),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, '/student-schedule-help'),
              child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.help_outline,
                      size: 30, color: Color(0xffC9D1D9))),
            )
          ],
        ),
        body: _buildCalendar());
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      constraints: const BoxConstraints.expand(),
      color: sBlackColor,
      child: SfCalendarTheme(
        data: SfCalendarThemeData(
          todayTextStyle: sWhiteTextStyle,
          timeTextStyle: sWhiteTextStyle,
          cellBorderColor: sBlackColor,
          headerTextStyle:
              sWhiteTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
          activeDatesBackgroundColor: sBlackColor,
          selectionBorderColor: sBlackColor,
          viewHeaderDayTextStyle: sWhiteTextStyle.copyWith(
            fontWeight: semiBold,
          ),
        ),
        child: SfCalendar(
          headerHeight: 50,
          todayHighlightColor: sRedColor,
          viewHeaderHeight: 50,
          appointmentTextStyle: sWhiteTextStyle,
          dataSource: MeetingDataSource(_getDataSource()),
          allowAppointmentResize: true,
          showNavigationArrow: true,
          view: CalendarView.month,
          monthViewSettings: MonthViewSettings(
              agendaViewHeight: 300,
              agendaItemHeight: 50,
              agendaStyle: AgendaStyle(
                backgroundColor: sBlackColor,
                appointmentTextStyle: sWhiteTextStyle,
                dateTextStyle: sWhiteTextStyle,
                dayTextStyle: sWhiteTextStyle,
              ),
              monthCellStyle: MonthCellStyle(
                textStyle: sWhiteTextStyle,
                leadingDatesTextStyle: sGreyTextStyle,
                trailingDatesTextStyle: sGreyTextStyle,
              ),
              showAgenda: true,
              navigationDirection: MonthNavigationDirection.horizontal),
          appointmentTimeTextFormat: 'hh:mm a',
        ),
      ),
    );
  }
}

List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  meetings.add(Meeting(
      'Piano Class - Mrs. Riri', startTime, endTime, sGreyColor, false));
  meetings.add(Meeting(
      'Piano Class - Mrs. Lina', startTime, endTime, sGreyColor, false));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
