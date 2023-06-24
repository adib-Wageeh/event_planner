import 'package:flutter/material.dart';

import '../../../../models/event_model/event_model.dart';

class WillAttendListViewWidget extends StatelessWidget {
  final List<EventAttendant> willAttend;
  const WillAttendListViewWidget({Key? key,required this.willAttend}) : super(key: key);

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
                const Text("Will attend"),
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
                child: Container(decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(24)
                ),child: ListTile(title: Text(willAttend[index].username))),
              );
            }, separatorBuilder: (context,index){return const SizedBox(height: 4);}, itemCount: willAttend.length),
          )
        ],
      ),
    );
  }
}
