import 'package:bloc/bloc.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../../../models/repositories/events_repository.dart';
import 'package:file_picker/file_picker.dart';

part 'add_event_state.dart';

class AddEventCubit extends Cubit<AddEventState> {
  AddEventCubit() : super(AddEventInitial());

  EventsRepository codeRepository = EventsRepository();
  TextEditingController title = TextEditingController();
  DateTime? selectedDate;
  FocusNode focusNode = FocusNode();
  List<PlatformFile> files = [];

  Future<void> addEvent(String codeId)async{
    emit(AddEventLoading());
    if(selectedDate != null && title.text.isNotEmpty){
      List<FileData> eventFiles=[];
      for (var element in files) {
        eventFiles.add(FileData(downloadUrl: element.path!, fileName: element.name));
      }
      final eventId = const Uuid().v4();
      EventModel eventModel = EventModel(id: eventId,attendants: const [],files:eventFiles,name: title.text, date: selectedDate!,dateAdded: DateTime.now());
      bool res = await codeRepository.addEvent(codeId, eventModel,eventId);
      if(res){
        emit(AddEventDone());
      }else{
        emit(AddEventError(error: "Event name already exists"));
      }
    }else if(selectedDate == null){
      emit(AddEventError(error: "Please select a date"));
    }else{
      emit(AddEventError(error: "Please select event title"));
    }
  }

  void addDate(DateTime newDate){
    selectedDate = newDate;
    emit(AddEventDate(dateTime: newDate));
  }



  void addFiles(List<PlatformFile> newFiles) {
    final currentFiles = files;
    final allFiles = [...currentFiles, ...newFiles];
    files = allFiles;
    emit(AddEventFiles(files: files));
  }

  void removeFileAt(int index) {
    files.removeAt(index);
    // final newFiles = List<PlatformFile>.from(files)..removeAt(index);
    emit(AddEventFiles(files: files));
  }

  void clearControllers(){
    title.clear();
    selectedDate = null;
    files = [];
    emit(AddEventInitial());
  }


}
