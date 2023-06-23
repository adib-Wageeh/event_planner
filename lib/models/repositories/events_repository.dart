import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../event_model/event_model.dart';
import 'messaging_repository.dart';

class EventsRepository{

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;


  Stream<List<EventModel>> getEvents(String code) async* {
    var codeSnapshot = await fireStore.collection('codes').doc(code).get();
      await for (var eventSnapshot in codeSnapshot.reference.collection('events').orderBy('dateAdded',descending: true).snapshots()) {
        List<EventModel> events = [];
        for (var eventDoc in eventSnapshot.docs) {
          var fileUrlsQuerySnapshot = await eventDoc.reference.collection('files').get();
          var files = fileUrlsQuerySnapshot.docs.map((fileUrlDoc) {
            return FileData(
              fileName: fileUrlDoc['name'],
              downloadUrl: fileUrlDoc['url'],
            );
          }).toList();
          var usersQuerySnapshot = await eventDoc.reference.collection('users').get();
          List<EventAttendant> users=[];
          if(usersQuerySnapshot.size>0){
            users = usersQuerySnapshot.docs.map((usersDoc) {
              return EventAttendant(
                username: usersDoc['username'],
                state: usersDoc['type'],
              );
            }).toList();
          }else{
            users =[];
          }
          events.add(EventModel(
            id: eventDoc.id,
            name: eventDoc['name'],
            date: eventDoc['date'].toDate(),
            dateAdded: eventDoc['dateAdded'].toDate(),
            files: files,
            attendants: users
          ));
        }
        yield events;
      }
  }


  Future<bool> addEvent(String codeId, EventModel event,String eventId)async{

    MessagingRepository messagingRepository = MessagingRepository();
      QuerySnapshot snapshot = await fireStore.collection('codes').doc(codeId).collection('events').where('name',isEqualTo: event.name).get();

      if(snapshot.size>0){
        return false;
      }else{
        List<Map<String,dynamic>> fileUrls = await Future.wait(
          event.files.map((file) async {
            final ref = storage.ref().child(codeId).child(eventId).child(file.fileName);
            final uploadTask = ref.putFile(File(file.downloadUrl));
            final snapshot = await uploadTask.whenComplete(() {});
            final downloadUrl = await snapshot.ref.getDownloadURL();
            return {'name': file.fileName, 'url': downloadUrl};
          }),
        );
        final docId = const Uuid().v4();
        for (var element in fileUrls) {
         await fireStore.collection('codes').doc(codeId).collection('events').doc(eventId).collection("files").add(element);
        }
        await fireStore.collection('codes').doc(codeId).collection('events').doc(eventId).set({
          "name":event.name,
          "date":event.date,
          "dateAdded":event.dateAdded
        });
        await messagingRepository.sendNotificationToUsers(codeId, event);

      }
      return true;
  }


  Future<bool> downloadFile(FileData fileData,String eventName) async {
    // Request storage permission

    Dio dio = Dio();
    try {
      Directory dir = Directory('/data/user/0/event planner/$eventName');
      // final directory = await getExternalStorageDirectories(type: StorageDirectory.downloads);
      // Create a file in the Downloads directory with the same name as the downloaded file
      final file = File('/storage/emulated/0/Download/event planner/$eventName/${fileData.fileName}');

      final response = await dio.download(
        fileData.downloadUrl,
        file.path,

      );
      //
      //
      // print(file.path);
      // final res = await OpenFile.open(file.path);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<bool> isAttendant(String username,EventModel eventModel,String codeId){

    return fireStore
        .collection('codes')
        .doc(codeId)
        .collection('events')
        .doc(eventModel.id)
        .collection('users')
        .where('username', isEqualTo: username)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  Future<void> acceptEvent(String username,EventModel eventModel,String codeId)async{

    await fireStore.collection('codes').doc(codeId).collection('events').doc(eventModel.id).collection("users").add({
      "username":username,
      "type":1
    });
  }

  Future<void> refuseEvent(String username,EventModel eventModel,String codeId)async{

    await fireStore.collection('codes').doc(codeId).collection('events').doc(eventModel.id).collection("users").add({
      "username":username,
      "type":2
    });
  }

  Future<void> deleteEvent(EventModel eventModel,String codeId)async{

    final ref = storage.ref().child(codeId).child(eventModel.id);
    await _deleteFolder(ref);
    final files = await fireStore.collection('codes').doc(codeId).collection("events").doc(eventModel.id).collection("files").get();
    for (var element in files.docs) {
      await element.reference.delete();
    }
    final users = await fireStore.collection('codes').doc(codeId).collection("events").doc(eventModel.id).collection("users").get();
    for (var element in users.docs) {
      await element.reference.delete();
    }
    await fireStore.collection('codes').doc(codeId).collection("events").doc(eventModel.id).delete();
  }


  Future<void> _deleteFolder(Reference ref) async {
    final ListResult result = await ref.listAll();

    for (final Reference ref in result.items) {
      await ref.delete();
    }
  }

}