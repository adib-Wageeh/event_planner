import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../models/event_model/event_model.dart';
import '../../viewModel/downloadFile/download_file_cubit.dart';

class FileWidget extends StatelessWidget {
  final FileData file;
  final String eventName;
  const FileWidget({required this.eventName,required this.file,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(child: Text(file.fileName)),
        BlocBuilder<DownloadFileCubit, DownloadFileState>(
          builder: (context, state) {
            if(state is DownloadFileDownloading && state.fileData.contains(file)) {
              return Stack(
                children: const [
                  TextButton(
                    onPressed: null, // Disable the button while the file is downloading
                    child: Text(
                      "",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }else{
              return TextButton(onPressed: () {
                context.read<DownloadFileCubit>().downloadFile(file,eventName);
              }, child: const Text("Download", style: TextStyle(color: Colors.blue),));
            }
          },
        )
      ],
    );
  }
}