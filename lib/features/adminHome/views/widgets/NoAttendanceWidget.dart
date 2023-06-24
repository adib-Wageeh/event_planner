import 'package:flutter/material.dart';

class NoAttendanceWidget extends StatelessWidget {
  const NoAttendanceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Icon(Icons.meeting_room_rounded,size: 56),
        Text("No responses yet",style: TextStyle( fontSize: 24), )
      ],
    ), );
  }
}