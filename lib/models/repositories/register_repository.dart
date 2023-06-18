import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:device_information/device_information.dart';
import 'package:event_planner/models/code_model/code_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterRepository{

  Future<Either<bool,CodeModel>> register(String code,String username)async{
    final imeiNo = await DeviceInformation.deviceIMEINumber;
    final fireStore = FirebaseFirestore.instance;
    // Query the 'codes' collection for the provided code
    final codeSnapshot = await fireStore.collection('codes').where('code',isEqualTo: code).get();
    if(codeSnapshot.size == 0){
      return const Left(false);
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if(codeSnapshot.docs[0].data()["employee"] == 0) {
      codeSnapshot.docs[0].reference.collection("admins").add({
        "username": username,
        "imei": imeiNo,
        "fcmToken": fcmToken
      }
      );
    }else{
      codeSnapshot.docs[0].reference.collection("users").add({
        "username": username,
        "imei": imeiNo,
        "fcmToken": fcmToken
      }
      );
    }
    int users = codeSnapshot.docs[0].data()["employee"];
    users +=1;
    codeSnapshot.docs[0].reference.update({"employee":users});
    return Right(CodeModel.fromJson(codeSnapshot.docs[0].data(), codeSnapshot.docs[0].id));
  }


}