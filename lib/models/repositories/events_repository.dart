import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../event_model/event_model.dart';

class EventsRepository{

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;


  Stream<List<EventModel>> getEvents(String code) async* {
    var codeSnapshot = await fireStore.collection('codes').doc(code).get();
    if (codeSnapshot.exists) {
      var eventQuerySnapshot = await codeSnapshot.reference.collection('events').orderBy('dateAdded').get();
      List<EventModel> events = await Future.wait(eventQuerySnapshot.docs.map((eventDoc) async {
        // Get the file URLs subcollection for the event
        var fileUrlsQuerySnapshot = await eventDoc.reference.collection('files').get();
        // Map the file URLs documents to FileModel objects
        var files = fileUrlsQuerySnapshot.docs.map((fileUrlDoc) {
          return FileData(
            fileName: fileUrlDoc['name'],
            downloadUrl: fileUrlDoc['url'],
          );
        }).toList();
        // Create an EventModel object with the event and file information
        return EventModel(
          name: eventDoc['name'],
          date: eventDoc['date'].toDate(),
          dateAdded: eventDoc['dateAdded'].toDate(),
          files: files,
        );
      }));
      yield events;
      await for (var eventSnapshot in codeSnapshot.reference.collection('events').orderBy('dateAdded').snapshots()) {
        events = await Future.wait(eventSnapshot.docs.map((eventDoc) async {
          // Get the file URLs subcollection for the event
          var fileUrlsQuerySnapshot = await eventDoc.reference.collection('files').get();
          // Map the file URLs documents to FileModel objects
          var files = fileUrlsQuerySnapshot.docs.map((fileUrlDoc) {
            return FileData(
              fileName: fileUrlDoc['name'],
              downloadUrl: fileUrlDoc['url'],
            );
          }).toList();
          // Create an EventModel object with the event and file information
          return EventModel(
            name: eventDoc['name'],
            date: eventDoc['date'].toDate(),
            dateAdded: eventDoc['dateAdded'].toDate(),
            files: files,
          );
        }));
        yield events;
      }
    }
  }


  Future<bool> addEvent(String codeId, EventModel event)async{

      QuerySnapshot snapshot = await fireStore.collection('codes').doc(codeId).collection('events').where('name',isEqualTo: event.name).get();

      if(snapshot.size>0){
        return false;
      }else{
        final eventId = const Uuid().v4();
        List<Map<String,dynamic>> fileUrls = await Future.wait(
          event.files.map((file) async {
            final ref = storage.ref().child('events').child(eventId).child(file.fileName);
            final uploadTask = ref.putFile(File(file.downloadUrl));
            final snapshot = await uploadTask.whenComplete(() {});
            final downloadUrl = await snapshot.ref.getDownloadURL();
            return {'name': file.fileName, 'url': downloadUrl};
          }),
        );

        final docId = await fireStore.collection('codes').doc(codeId).collection('events').add({
          "name":event.name,
          "date":event.date,
          "dateAdded":event.dateAdded
        });
        for (var element in fileUrls) {
          fireStore.collection('codes').doc(codeId).collection('events').doc(docId.id).collection("files").add(element);
        }
      }
      return true;
  }


}