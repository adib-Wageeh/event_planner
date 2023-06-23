import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../../../../models/event_model/event_model.dart';
import '../../viewModel/Attend/attend_cubit.dart';

class AcceptOrRefuseEventWidget extends StatelessWidget {
  final EventModel eventModel;
  final String username;
  final String codeId;
  const AcceptOrRefuseEventWidget({required this.codeId,required this.username,required this.eventModel,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final now = snapshot.data;
          final eventDate = eventModel.date;
          if (!eventDate.difference(now!).isNegative ){
            return StreamBuilder<bool>(
              stream: context.read<AttendCubit>().isAttendant(username, eventModel, codeId),
              builder: (context, snapshot) {
                if (snapshot.hasData && !snapshot.data!) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(onPressed: () async {
                        await context.read<AttendCubit>().acceptEvent(
                            username, eventModel, codeId);
                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kAppAccentColor),
                        child: const Text("Accept"),
                      ),
                      ElevatedButton(onPressed: () async {
                        await context.read<AttendCubit>().refuseEvent(
                            username, eventModel, codeId);
                      },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kAppAccentColor),
                        child: const Text("Refuse"),
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }
}