import 'package:event_planner/features/adminHome/viewModel/getEvents/get_events_cubit.dart';
import 'package:event_planner/features/adminHome/views/widgets/AttendanceListViewWidget.dart';
import 'package:event_planner/features/adminHome/views/widgets/NoAttendanceWidget.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventAttendanceView extends StatelessWidget {
  final EventModel eventModel;
  final String codeId;
  const EventAttendanceView({required this.codeId,required this.eventModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eventModel.name),),
      body: StreamBuilder<EventModel>(
        stream: context.read<GetEventsCubit>().getEventAttendances(eventModel, codeId),
        builder: (context,snapShot){
          if(snapShot.hasData){
            if(snapShot.data!.attendants.isEmpty){
              return const NoAttendanceWidget();
            }else {
              return AttendanceListViewWidget(eventModel: snapShot.data!,);
            }
          }
          return const Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}





