import 'package:event_planner/features/adminHome/viewModel/downloadFile/download_file_cubit.dart';
import 'package:event_planner/features/adminHome/viewModel/getEvents/get_events_cubit.dart';
import 'package:event_planner/features/adminHome/views/widgets/ListOfEventsWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/viewModel/current_user/current_user_cubit.dart';
import 'widgets/AddEventButton.dart';
import 'widgets/NoEventsWidget.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(context.read<UserCubit>().state!.codeModel.company)),
      body: BlocListener<DownloadFileCubit, DownloadFileState>(
  listener: (context, state) {
    if(state is DownloadFileDownloaded){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.fileData.fileName} Downloaded")));
    }
  },
  child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<GetEventsCubit, GetEventsState>(
                    builder: (context, state) {
                      if (state is GetEventsLoaded) {
                        if(state.events.isNotEmpty) {
                          return ListOfEventsWidget(events: state.events,);
                        }else{
                          return const NoEventsWidget();
                        }
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: const AddEventButton(),
              ),
              ],
              ),
)
    );
  }
}
