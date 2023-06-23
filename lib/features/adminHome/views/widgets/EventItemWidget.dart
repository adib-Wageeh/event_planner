import 'package:event_planner/constants.dart';
import 'package:event_planner/features/adminHome/viewModel/deleteEvent/delete_event_cubit.dart';
import 'package:event_planner/features/authentication/viewModel/current_user/current_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../models/event_model/event_model.dart';
import '../../../userHome/views/widgets/AcceptOrRefuseEventWidget.dart';
import 'FileWidget.dart';
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
                title: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextEventItemWidget(text: event.name,label: "Event: "),
                          ],
                        ),
                      ),
                    ),
                    (context.read<UserCubit>().state!.isAdmin)?
                    DeleteEventWidget(eventModel: event,codeId: context.read<UserCubit>().state!.codeModel.id,):Container()
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextEventItemWidget(text: DateFormat('dd/MM/yyyy hh:mm a').format(event.date),label: "Date: ",textColor: textColor,),
                    ...event.files.map((e) => FileWidget(file: e,eventName: event.name,)).toList()
                  ],
                ),
              ),
              (context.read<UserCubit>().state!.isAdmin)?
                  Container():
              (context.read<UserCubit>().state!.isAdmin)?
                  Container(): AcceptOrRefuseEventWidget(codeId: context.read<UserCubit>().state!.codeModel.id,eventModel: event,username: context.read<UserCubit>().state!.username,)
            ],
          ),
        )
    );
  }
}

class DeleteEventWidget extends StatelessWidget {
  final EventModel eventModel;
  final String codeId;
  const DeleteEventWidget({required this.codeId,required this.eventModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(onPressed: (){

      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: const Text("are you sure you want to delete the event ?"),
          actions:
          [
            BlocBuilder<DeleteEventCubit,DeleteEventState>(
              builder: (context,state){
                if(state is DeleteEventLoading){
                  return Container();
                }
               return TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: const Text("cancel"));
              },
            ),
            BlocBuilder<DeleteEventCubit,DeleteEventState>(
              builder: (context,state){
                if(state is DeleteEventLoading){
                  return const Center(child: CircularProgressIndicator());
                }
               return ElevatedButton(onPressed: ()async{
                 await context.read<DeleteEventCubit>().deleteEvent(eventModel, codeId);
                 Navigator.pop(context);
               },
                  style: ElevatedButton.styleFrom(backgroundColor: kAppAccentColor),
                 child: const Text("Delete"),);
              },
            ),

          ],
        );
      });
    }, icon: const Icon(Icons.delete));
  }
}
