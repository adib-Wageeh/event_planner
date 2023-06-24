import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../../../models/event_model/event_model.dart';
import '../../viewModel/deleteEvent/delete_event_cubit.dart';

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