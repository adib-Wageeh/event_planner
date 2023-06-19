import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../models/event_model/event_model.dart';
import 'TextEventItemWidget.dart';

class EventItemWidget extends StatelessWidget {
  final EventModel event;
  const EventItemWidget({Key? key,required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    Color textColor = event.date.isAfter(currentDate) ? Colors.green : Colors.grey;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black54
          ),
          child: Column(
            children: [
              ListTile(
                title: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextEventItemWidget(text: event.name,label: "Event: "),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextEventItemWidget(text: DateFormat('dd/MM/yyyy hh:mm a').format(event.date),label: "Date: ",textColor: textColor,),
                    ...event.files.map((e) => FileWidget(file: e,)).toList()
                  ],
                )
                // trailing: ActivationButtonCodeItemWidget(code: code),
              ),

              // Row(
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //     ButtonCodeItemWidget(icon: Icons.edit_note,text: "Edit", onPress: (){
              //       showDialog(
              //           barrierDismissible: false
              //           , context: context, builder: (context) {
              //         return EditCodeWidget(codeModel: code,);
              //       });
              //     }, ),
              //     const SizedBox(width: 12,),
              //     ButtonCodeItemWidget(onPress: (){
              //       showDialog(
              //         context: context,
              //         builder: (BuildContext context) {
              //           return DeleteDialogBoxWidget(code: code,);
              //         },
              //       );
              //     }, text: "Delete", icon: Icons.delete,
              //     ),
              //   ],
              // ),
            ],
          ),
        )
    );
  }
}

class FileWidget extends StatelessWidget {
  final FileData file;
  const FileWidget({required this.file,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(child: Text(file.fileName)),
        TextButton(onPressed: (){}, child: const Text("Download",style: TextStyle(color: Colors.blue),))
      ],
    );
  }
}
