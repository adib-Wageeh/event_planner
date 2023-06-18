
import 'package:flutter/material.dart';

class BlockedCodeWidget extends StatelessWidget {
  const BlockedCodeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.black54,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("Your Code have been deActivated from the moderator.",textAlign: TextAlign.center,)
          ],
        ),
      ),
    );
  }
}
