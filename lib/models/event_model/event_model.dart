import 'package:equatable/equatable.dart';

class EventModel extends Equatable {

  String name;
  DateTime date;
  DateTime dateAdded;
  List<FileData> files;

  EventModel({required this.files,required this.dateAdded,required this.name, required this.date});

  @override
  // TODO: implement props
  List<Object?> get props => [name,date,dateAdded];
}

class FileData {
  String fileName;
  String downloadUrl;

  FileData({required this.downloadUrl,required this.fileName});



}