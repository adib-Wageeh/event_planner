import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:event_planner/models/code_model/code_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../code_model/user_model.dart';

class CodesRepository{

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Stream<Either<bool, UserModel>> checkAuthenticated(String myIMEI) {
    final CollectionReference<Map<String, dynamic>> collectionRef = fireStore.collection('codes');
    return collectionRef.snapshots().asyncMap((event) async {
      for (var doc in event.docs) {

        // checks if imei exists in users
        final QuerySnapshot<Map<String, dynamic>> userDocRef = await doc.reference.collection('users').where('imei',isEqualTo: myIMEI).get();
         if(userDocRef.size>0){
          if (doc.get('activation') == true) {
            // found and activated
            final fcmToken = await messaging.getToken();
            await userDocRef.docs[0].reference.update({"fcmToken":fcmToken});
            CodeModel codeModel = CodeModel.fromJson(doc.data(), doc.id);
            return Right(UserModel.fromJson(userDocRef.docs[0].data(),userDocRef.docs[0].id,
                false, codeModel));
          } else {
            // found but deactivated
            return const Left(true);
          }
           // checks if imei exists in admins
        }else {
           final QuerySnapshot<Map<String, dynamic>> adminsDocRef = await doc.reference.collection('admins').where('imei',isEqualTo: myIMEI).get();
           if (adminsDocRef.size > 0) {
             if (doc.get('activation') == true) {
               // found and activated
               final fcmToken = await messaging.getToken();
               await adminsDocRef.docs[0].reference.update({"fcmToken":fcmToken});
               CodeModel codeModel = CodeModel.fromJson(doc.data(), doc.id);
               return Right(UserModel.fromJson(adminsDocRef.docs[0].data(),adminsDocRef.docs[0].id,
                   true, codeModel));
             } else {
               // found but deactivated
               return const Left(true);
             }
           }
         }
        }
      // not found in db
      return const Left(false); // Return a failure case if code is not found
    });
  }

}