// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:flutter/material.dart';

import '../shared/theme.dart';

class ParentInformationCard extends StatefulWidget {
  String relation;
  String name;
  String email;
  String mobile;
  String job;
  String sosmed;

  ParentInformationCard({
    Key? key,
    required this.relation,
    required this.name,
    required this.email,
    required this.mobile,
    required this.job,
    required this.sosmed,
  }) : super(key: key);

  @override
  State<ParentInformationCard> createState() => _ParentInformationCardState();
}

class _ParentInformationCardState extends State<ParentInformationCard> {
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
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
            color: _checkIconColor(widget.relation),
          ),
          height: 100,
          width: 100,
          child: Icon(
            _checkIcon(widget.relation),
            color: Colors.white,
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
                      Text(widget.name,
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
                                    Icons.mail_outline,
                                    size: 20,
                                    color: Color(0XFF8E8E8E),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(widget.email,
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
                              Icons.work_outline,
                              size: 20,
                              color: Color(0XFF8E8E8E),
                            ),
                            Container(
                              width: 90,
                              child: Container(
                                child: SizedBox(
                                  child: Text(widget.job,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 20,
                                    color: Color(0XFF8E8E8E),
                                  ),
                                  Container(
                                    width: 90,
                                    child: Container(
                                      child: SizedBox(
                                        child: Text(widget.mobile,
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
                              Icons.alternate_email,
                              size: 20,
                              color: Color(0XFF8E8E8E),
                            ),
                            Container(
                              width: 90,
                              child: Container(
                                child: SizedBox(
                                  child: Text(widget.sosmed,
                                      overflow: TextOverflow.ellipsis,
                                      style: fTextColorStyle.copyWith()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

  _checkIcon(relation) {
    if (relation == 'Father') {
      return Icons.boy;
    } else if (relation == 'Mother') {
      return Icons.girl;
    } else {
      return Icons.question_mark_sharp;
    }
  }

  _checkIconColor(relation) {
    if (relation == 'Father') {
      return const Color(0xff2D7AB1);
    } else if (relation == 'Mother') {
      return const Color(0xffC8239A);
    } else {
      return const Color(0xff616161);
    }
  }
}
