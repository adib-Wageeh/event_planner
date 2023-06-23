import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../adminHome/viewModel/downloadFile/download_file_cubit.dart';
import '../../adminHome/viewModel/getEvents/get_events_cubit.dart';
import '../../adminHome/views/widgets/ListOfEventsWidget.dart';
import '../../adminHome/views/widgets/NoEventsWidget.dart';
import '../../authentication/viewModel/current_user/current_user_cubit.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.read<UserCubit>().state!.codeModel.company)),
        body: BlocListener<DownloadFileCubit, DownloadFileState>(
          listener: (context, state) {
            if(state is DownloadFileDownloaded){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${state.fileData.fileName} Downloaded")));
            }
          },
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
        )
    );
  }
}
