import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../shared/theme.dart';
import '../../../widget/no_scroll_waves.dart';

class StudentEnrollmentHistoryPage extends StatefulWidget {
  const StudentEnrollmentHistoryPage({Key? key}) : super(key: key);

  @override
  State<StudentEnrollmentHistoryPage> createState() =>
      _StudentEnrollmentHistoryPageState();
}

class _StudentEnrollmentHistoryPageState
    extends State<StudentEnrollmentHistoryPage> {
  var itemList = ['', ''];
  int defaultChoiceIndex = 0;
  final List<String> _choicesList = [
    'All',
    'Approved',
    'Stoped',
    'Graduated',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return _buildStudentAttendancePage();
  }

  Widget _buildStudentAttendancePage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text(
          'Enrollment History',
          style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
        ),
      ),
      body: ScrollConfiguration(
        behavior: NoScrollWaves(),
        child: SingleChildScrollView(
          child: SizedBox(
              child: Column(
            children: [
              const SizedBox(height: 10),
              _buildChip(),
              const SizedBox(height: 10),
              _buildAttendanceList(),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildChip() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Row(children: [
          Wrap(
            spacing: 4,
            children: List.generate(_choicesList.length, (index) {
              return ChoiceChip(
                labelPadding: EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                label: Text(
                  _choicesList[index],
                  style: sWhiteTextStyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Color(0xff444C56))),
                selected: defaultChoiceIndex == index,
                selectedColor: const Color(0xff2D333B),
                onSelected: (value) {
                  setState(() {
                    defaultChoiceIndex = value ? index : defaultChoiceIndex;
                  });
                },
                backgroundColor: sBlackColor,
                elevation: 1,
                padding: EdgeInsets.symmetric(horizontal: 10),
              );
            }),
          )
        ]),
      ),
    );
  }

  Widget _buildAttendanceList() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            ...itemList.map((item) {
              return _buildAttendanceCard();
            }).toList(),
          ],
        ));
  }

  Widget _buildAttendanceCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff181B1E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ENR-2206-T-AS-00006',
                style: sWhiteTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              Material(
                color: sBlackColor,
                child: InkWell(
                  splashColor: sGreyColor,
                  borderRadius: BorderRadius.circular(4),
                  onTap: () {},
                  child: Container(
                    height: 20,
                    width: 50,
                    decoration: BoxDecoration(
                      color: sGreenColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                        child: Text(
                      'Paid',
                      style: sWhiteTextStyle.copyWith(fontWeight: semiBold),
                    )),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Ahmad Mad - DR - Drum',
            style: sGreyTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '20 Sept 2022',
            style: sGreyTextStyle.copyWith(
              fontSize: 12,
              fontWeight: semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
