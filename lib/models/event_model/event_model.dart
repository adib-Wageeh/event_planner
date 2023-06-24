import 'package:equatable/equatable.dart';

class EventModel extends Equatable {

  String name;
  DateTime date;
  DateTime dateAdded;
  List<FileData> files;
  String id;
  List<EventAttendant> attendants;
  EventModel({required this.id,required this.attendants,required this.files,required this.dateAdded,required this.name, required this.date});

  EventModel copyWith({
    String? name,
    DateTime? date,
    DateTime? dateAdded,
    List<FileData>? files,
    String? id,
    List<EventAttendant>? attendants,
  }) {
    return EventModel(
      name: name ?? this.name,
      date: date ?? this.date,
      dateAdded: dateAdded ?? this.dateAdded,
      files: files ?? this.files,
      id: id ?? this.id,
      attendants: attendants ?? this.attendants,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [name,date,dateAdded,attendants,files];

  
}

class FileData extends Equatable{
  String fileName;
  String downloadUrl;

  FileData({required this.downloadUrl,required this.fileName});

  @override
  // TODO: implement props
  List<Object?> get props => [fileName,downloadUrl];

}

class EventAttendant extends Equatable{

  String username;
  int state;

  EventAttendant({required this.state,required this.username});

  @override
  // TODO: implement props
  List<Object?> get props => [username,state];

}
