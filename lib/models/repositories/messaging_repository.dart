import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/models/event_model/event_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MessagingRepository{

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final key = 'AAAAgQDf_yY:APA91bGSGRlkjwpMZLo0oEiffbOeeqs4_TIT2dWtTz0-SPYSFrZLwSdT44At1bTfl8H_AwlN9AT10mFnPUKf4vTxU8-ygXBAGRzMQFBxzRpf0lq_aBO7LyYiIZXG3Vi1bi2DzEfqLUX3';


  Future<void> sendNotificationToUsers(String codeId, EventModel event) async {
    // Get the FCM tokens of all users in the users collection of the specified code
    final QuerySnapshot snapshot =
    await fireStore.collection('codes/$codeId/users').get();

    final List<String> tokens = [];

    for (final QueryDocumentSnapshot doc in snapshot.docs) {
      final token = doc.get('fcmToken');
      if (token != null) {
        tokens.add(token);
      }
    }

    // Send the notification to each user
    for (final token in tokens) {

      try {
        var data = {
          "to":token.toString(),
          'priority': 'high',
          'notification': {
            'title': 'New Event !',
            'body': 'Event: ${event.name} \nDate: ${DateFormat('dd/MM/yyyy hh:mm a').format(event.date)}  '
          }
        };
       final result = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
          headers: {'Content-Type':'application/json; charset=UTF-8',
          'Authorization': 'key=$key'
          }
        );
       print(result.body);
      } catch (e) {
        print(e);
      }
    }


  }


}