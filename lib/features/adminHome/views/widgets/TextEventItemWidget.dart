import 'package:flutter/material.dart';

import '../../../../constants.dart';

class TextEventItemWidget extends StatelessWidget {
  const TextEventItemWidget({
    super.key,
    required this.text,
    required this.label,
    this.textColor
  });

  final String text;
  final String label;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label,
            style: TextStyle(color: kAppAccentColor,fontSize: 16, overflow: TextOverflow.ellipsis),
          ),
          TextSpan(
              text: text,style: TextStyle(fontSize: 20, overflow: TextOverflow.ellipsis,
              color: (textColor == null)? Colors.white:textColor)
          ),
        ],
      ),
    );
  }
}