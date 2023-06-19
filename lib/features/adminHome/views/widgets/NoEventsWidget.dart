import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoEventsWidget extends StatelessWidget {
  const NoEventsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(FontAwesomeIcons.peopleGroup, size: 36),
          SizedBox(height: 12),
          Text(
            "No Events yet",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}
