import 'package:flutter/material.dart';

import 'package:add_2_calendar/add_2_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  Event buildEvent({Recurrence? recurrence}) {
    return Event(
      title: 'ngeeng',
      description: 'tes',
      location: 'smi',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 28 ),
      ),
      androidParams: AndroidParams(
        emailInvites: ["test@example.com"],
      ),
      recurrence: recurrence,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('send google calendar'),
        ),
        body: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('add normal event'),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );
              },
            ),
            // Divider(),
            // ListTile(
            //   title: const Text('Add event with recurrence 1'),
            //   subtitle: const Text("weekly for 3 months"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.weekly,
            //         endDate: DateTime.now().add(Duration(days: 60)),
            //       ),
            //     ));
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   title: const Text('Add event with recurrence 2'),
            //   subtitle: const Text("every 2 months for 6 times (1 year)"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.monthly,
            //         interval: 2,
            //         ocurrences: 6,
            //       ),
            //     ));
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   title: const Text('Add event with recurrence 3'),
            //   subtitle:
            //       const Text("RRULE (android only) every year for 10 years"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.yearly,
            //         rRule: 'FREQ=YEARLY;COUNT=10;WKST=SU',
            //       ),
            //     ));
            //   },
            // ),
            // Divider(),
          ],
        ),
      ),
    );
  }
}