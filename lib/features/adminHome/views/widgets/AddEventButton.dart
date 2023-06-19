import 'package:flutter/material.dart';

import '../../../../constants.dart';
import 'AddEventWidget.dart';

class AddEventButton extends StatelessWidget {
  const AddEventButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kAppAccentColor
        )
        ,onPressed: () {
      showDialog(
          barrierDismissible: false
          , context: context, builder: (context) {
        return const AddEventWidget();
      });
    }, child: const Text("Add"));
  }
}
