import 'package:bloc/bloc.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:meta/meta.dart';

import '../../../../models/repositories/events_repository.dart';

part 'download_file_state.dart';

class DownloadFileCubit extends Cubit<DownloadFileState> {
  DownloadFileCubit() : super(DownloadFileInitial());
  List<FileData> files=[];
  EventsRepository eventsRepository = EventsRepository();

  Future<void> downloadFile(FileData fileData,String eventName)async{
    files.add(fileData);
    emit(DownloadFileDownloading(fileData: files));
    final res = await eventsRepository.downloadFile(fileData,eventName);
    if(res){
      emit(DownloadFileDownloaded(fileData: fileData));
    }else{
      emit(DownloadFileDownloadError());
    }
    files.remove(fileData);
  }

}
