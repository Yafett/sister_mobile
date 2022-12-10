// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unused_field, prefer_typing_uninitialized_variables, avoid_print, sized_box_for_whitespace
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';

import 'package:sister_mobile/shared/theme.dart';

class StudentScheduleDetailPage extends StatefulWidget {
  String title;
  String date;

  DateTime startDate;
  DateTime endDate;
  String instructor;
  String location;

  StudentScheduleDetailPage({
    Key? key,
    required this.title,
    required this.date,
    required this.startDate,
    required this.endDate,
    required this.instructor,
    required this.location,
  }) : super(key: key);

  @override
  State<StudentScheduleDetailPage> createState() =>
      _StudentScheduleDetailPageState();
}

class _StudentScheduleDetailPageState extends State<StudentScheduleDetailPage> {
  GoogleMapController? controller;

  String? _topModalData;

  final CameraPosition initialPosition = const CameraPosition(
      target: LatLng(-6.973245480531463, 110.39053279088024), zoom: 50);
  var typemap = MapType.normal;
  var cordinate1 = 'cordinate';
  var lat = -6.973245480531463;
  var long = 110.39053279088024;
  var address = '';
  var options = [
    MapType.normal,
    MapType.hybrid,
    MapType.terrain,
    MapType.satellite,
  ];

  final searchController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  var description;

  var duration;

  final _currentItemSelected = MapType.normal;

  var listDuration = [15, 30, 45, 60, 120];

  Future<void> getAddress(latt, longg) async {
    List<Placemark> placemark = await placemarkFromCoordinates(latt, longg);
    print(
        '-----------------------------------------------------------------------------------------');
    //here you can see your all the relevent information based on latitude and logitude no.
    print(placemark);
    print(
        '-----------------------------------------------------------------------------------------');
    Placemark place = placemark[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildScheduleDetailsPage();
  }

  Widget _buildScheduleDetailsPage() {
    return Scaffold(
      backgroundColor: sBlackColor,
      appBar: AppBar(
        backgroundColor: sBlackColor,
        leading: const BackButton(color: Color(0xffC9D1D9)),
        title: Text('Details  ',
            style: sWhiteTextStyle.copyWith(fontWeight: semiBold)),
        actions: [
          GestureDetector(
            onTap: () async {
              var value =
                  await showTopModalSheet<String?>(context, dummyModal());

              setState(() {
                _topModalData = value;
              });
            },
            // Navigator.pushNamed(context, '/student-schedule-help'),
            child: Container(
                margin: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.edit_calendar,
                    size: 30, color: Color(0xffC9D1D9))),
          )
        ],
      ),
      body: _buildSchedule(),
    );
  }

  Widget _buildSchedule() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: sBlackColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 10),
        _buildScheduleHeader(),
        const SizedBox(height: 30),
        _buildScheduleBody(),
        const SizedBox(height: 10),
        // _buildAddCalendarButton(),
      ]),
    );
  }

  Widget _buildScheduleHeader() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        backgroundImage: AssetImage('assets/images/lord-shrek.jpg'),
      ),
      const SizedBox(height: 20),
      Text(widget.title,
          style: sWhiteTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20)),
      Text(
          'lorem ipsum dolor sit amet, consectetur adipiscing, lorem ipsum dolor sit amet, si consectetur adipiscing name',
          style: sGreyTextStyle.copyWith(fontWeight: semiBold, fontSize: 16)),
    ]);
  }

  Widget _buildScheduleBody() {
    String formattedDate = DateFormat('EEEE, dd MMMM').format(widget.startDate);
    String formattedEndDate = DateFormat('hh:mm a').format(widget.endDate);
    String formattedStartDate = DateFormat('hh:mm a').format(widget.startDate);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                color: sWhiteColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                formattedDate,
                style:
                    sGreyTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.watch_later_outlined,
                color: sWhiteColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                ' ${formattedStartDate.toString()} - ${formattedEndDate.toString()}',
                style:
                    sGreyTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.person,
                color: sWhiteColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.instructor,
                style:
                    sGreyTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              )
            ],
          ),
          Column(children: [
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: sWhiteColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Sekolah Musik Indonesia - ${widget.location}',
                  style: sGreyTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold),
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  color: sBlackColor,
                  size: 25,
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.27,
                  color: sGreyColor,
                  height: 150,
                  child: GoogleMap(
                    initialCameraPosition: initialPosition,
                    mapType: typemap,
                    onMapCreated: (controller) {
                      setState(() {
                        controller = controller;
                      });
                    },
                    onTap: (cordinate) {
                      setState(() {
                        lat = cordinate.latitude;
                        long = cordinate.longitude;
                        getAddress(lat, long);

                        cordinate1 = cordinate.toString();
                      });
                    },
                  ),
                )
              ],
            ),
          ]),
        ],
      ),
    );
  }

  // Widget _buildAddCalendarButton() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  //     color: sGreenColor,
  //     child: Row(
  //       children: [
  //         Icon(Icons.add, color: sWhiteColor),
  //         Text(
  //           'Add to Calendar',
  //           style: sWhiteTextStyle,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  _showModalBottom() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: sBlackColor,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Description', style: fTextColorStyle),
                const SizedBox(height: 5),
                TextFormField(
                  style: sWhiteTextStyle,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: sGreyColor,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: sBlackColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: sBlackColor),
                    ),
                    hintText: 'e.x John Doe',
                    hintStyle: fGreyTextStyle,
                  ),
                ),
                const SizedBox(height: 15),

                // ! Unit Field
                Text('Duration', style: fTextColorStyle),
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      color: sGreyColor,
                      border: Border.all(color: sBlackColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButton(
                      dropdownColor: sGreyColor,
                      style: sWhiteTextStyle,
                      underline: const SizedBox(),
                      isExpanded: true,
                      hint: Text('e.x duration', style: fGreyTextStyle),
                      items: listDuration.map((item) {
                        return DropdownMenuItem(
                          value: item.toString(),
                          child: Text('${item.toString()} Minutes'),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          duration = newVal;
                        });
                        Navigator.pop(context);
                      },
                      value: duration,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () => Add2Calendar.addEvent2Cal(
                    buildEvent(),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: sGreyColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: sBlackColor)),
                    child: Center(
                        child: Text(
                      'Add to Calendar',
                      style: sWhiteTextStyle,
                    )),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _showTopModal() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text("Choose Wisely",
              style: TextStyle(color: Colors.teal, fontSize: 20),
              textAlign: TextAlign.center),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 5),
                child: OutlinedButton(
                  child: Column(
                    children: [
                      FlutterLogo(
                        size: MediaQuery.of(context).size.height * .15,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text("CF Cruz Azul"),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop("CF Cruz Azul");
                  },
                ),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: OutlinedButton(
                  child: Column(
                    children: [
                      FlutterLogo(
                        size: MediaQuery.of(context).size.height * .15,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Text("Monarcas FC"),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).pop("Monarcas FC");
                  },
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }

  Event buildEvent({Recurrence? recurrence}) {
    var myInt = int.parse(duration);
    return Event(
      title: widget.title,
      description: _descriptionController.text,
      location: widget.location,
      startDate: widget.startDate,
      endDate: widget.endDate,
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: myInt),
      ),
      androidParams: const AndroidParams(
        emailInvites: [],
      ),
      recurrence: recurrence,
    );
  }

  dummyModal() {
    return Container(
      color: sBlackColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 30),
          Text('Description', style: fTextColorStyle),
          const SizedBox(height: 5),
          TextFormField(
            style: sWhiteTextStyle,
            controller: _descriptionController,
            decoration: InputDecoration(
              filled: true,
              fillColor: sGreyColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: sBlackColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: sBlackColor),
              ),
              hintText: 'e.x John Doe',
              hintStyle: fGreyTextStyle,
            ),
          ),
          const SizedBox(height: 15),

          // ! Unit Field
          Text('Duration', style: fTextColorStyle),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              decoration: BoxDecoration(
                color: sGreyColor,
                border: Border.all(color: sBlackColor),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton(
                dropdownColor: sGreyColor,
                style: sWhiteTextStyle,
                underline: const SizedBox(),
                isExpanded: true,
                hint: Text('e.x duration', style: fGreyTextStyle),
                items: listDuration.map((item) {
                  return DropdownMenuItem(
                    value: item.toString(),
                    child: Text('${item.toString()} Minutes'),
                  );
                }).toList(),
                onChanged: (newVal) {
                  setState(() {
                    duration = newVal;
                  });
                  Navigator.pop(context);
                },
                value: duration,
              ),
            ),
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: () => Add2Calendar.addEvent2Cal(
              buildEvent(),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                  color: sGreyColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sBlackColor)),
              child: Center(
                  child: Text(
                'Add to Calendar',
                style: sWhiteTextStyle,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
