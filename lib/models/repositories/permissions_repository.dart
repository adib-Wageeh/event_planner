import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionName{
 notification,storage,phone,none

}

class PermissionRepository{


  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<PermissionName> checkPermission(TargetPlatform platform)async{

    // Request phone state permission
    var phoneStatus = await Permission.phone.status;
    if (!phoneStatus.isGranted) {
      phoneStatus = await Permission.phone.request();
    }
    if(!phoneStatus.isGranted){
      return PermissionName.phone;
    }

    PermissionStatus? storageStatus;


    if(platform == TargetPlatform.android) {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      final apiLevel = deviceInfo.version.sdkInt;
      storageStatus = await Permission.storage.status;
      if(apiLevel < 30){
      if (!storageStatus.isGranted) {
        storageStatus = await Permission.storage.request();
        if(!storageStatus.isGranted){
          return PermissionName.storage;
        }
      }
      }
    }

    int notificationPermission = await _requestPermission();
    if(notificationPermission != 1){
      return PermissionName.notification;
    }
    return PermissionName.none;
  }

  Future<int> _requestPermission()async{


    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      return 1;
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      return 2;
    }else{
      return 3;
    }

  }

}