import 'package:flutter/material.dart';

import '../../../../models/event_model/event_model.dart';
import 'EventItemWidget.dart';

class ListOfEventsWidget extends StatelessWidget {
  final List<EventModel> events;
  const ListOfEventsWidget({Key? key,required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return EventItemWidget(
          event: events[index],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemCount: events.length,
    );
  }
}
