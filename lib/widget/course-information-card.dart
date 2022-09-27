// ignore_for_file: public_member_api_docs, sort_constructors_first, sized_box_for_whitespace, avoid_unnecessary_containers, must_be_immutable, file_names
import 'package:flutter/material.dart'; 

import '../shared/theme.dart';

class CourseInformationCard extends StatefulWidget {
  String className;
  String duration;
  String major;
  String type;

  CourseInformationCard({
    Key? key,
    required this.className,
    required this.duration,
    required this.major,
    required this.type,
  }) : super(key: key);

  @override
  State<CourseInformationCard> createState() => _CourseInformationCardState();
}

class _CourseInformationCardState extends State<CourseInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius:   BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            color: Color(0xffDFDFDF),
          ),
          height: 100,
          width: 100,
          child: Icon(
            _checkIcon(widget.major),
            color:const  Color(0xff313131),
            size: 50,
          ),
        ),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.className,
                          style: fBlackTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Icon(Icons.close_rounded),
                    ]),
                Row(
                  children: [
                    // ! sect 1
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom : 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.watch_later_outlined,
                                    size: 20,
                                    color: Color(0XFF8E8E8E),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(widget.duration,
                                            overflow: TextOverflow.ellipsis,
                                            style: fTextColorStyle.copyWith()),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 20,
                              color: Color(0XFF8E8E8E),
                            ),
                            Container(
                              width: 90,
                              child: Container(
                                child: SizedBox(
                                  child: Text(widget.type,
                                      overflow: TextOverflow.ellipsis,
                                      style: fTextColorStyle.copyWith()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // ! sect 2
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.music_note_outlined,
                            size: 20,
                            color: Color(0XFF8E8E8E),
                          ),
                          Container(
                            width: 90,
                            child: Container(
                              child: SizedBox(
                                child: Text(widget.major,
                                    overflow: TextOverflow.ellipsis,
                                    style: fTextColorStyle.copyWith()),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  _checkIcon(major) {
    if (major == 'Piano') {
      return Icons.piano;
    } else if (major == 'Vocal') {
      return Icons.mic;
    } else {
      return Icons.question_mark_sharp;
    }
  }
}
