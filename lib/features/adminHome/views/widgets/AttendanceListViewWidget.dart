
import 'package:flutter/material.dart';

import '../../../../models/event_model/event_model.dart';
import 'WillAttendListViewWidget.dart';
import 'WillNotAttendListViewWidget.dart';

class AttendanceListViewWidget extends StatelessWidget {
  final EventModel eventModel;

  const AttendanceListViewWidget({
    required this.eventModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<EventAttendant> willAttend = eventModel.attendants.where((element) => (element.state == 1)).toList();
    List<EventAttendant> willNotAttend = eventModel.attendants.where((element) => (element.state == 2)).toList();

    return Column(
        children: [
          (willAttend.isNotEmpty)?WillAttendListViewWidget(willAttend: willAttend,):Container(),
          (willNotAttend.isNotEmpty)?WillNotAttendListViewWidget(willNotAttend: willNotAttend,):Container()
        ]
    );
  }
}
