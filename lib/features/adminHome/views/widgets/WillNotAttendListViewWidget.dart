import 'package:flutter/material.dart';

import '../../../../models/event_model/event_model.dart';

class WillNotAttendListViewWidget extends StatelessWidget {
  final List<EventAttendant> willNotAttend;
  const WillNotAttendListViewWidget({Key? key,required this.willNotAttend}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(decoration: const BoxDecoration(color: Colors.white),width: double.infinity,height: 0.2,),
                )),
                const Text("Will Not attend"),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(decoration: const BoxDecoration(color: Colors.white),width: double.infinity,height: 0.2,),
                )),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.black54
                    )
                    ,child: ListTile(title: Text(willNotAttend[index].username),)),
              );
            }, separatorBuilder: (context,index){return const SizedBox(height: 4);}, itemCount: willNotAttend.length),
          )
        ],
      ),
    );
  }
}