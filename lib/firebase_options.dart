// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8yrbuLiRuOBgFw_WgNxDjS8achUf67nk',
    appId: '1:554065461030:android:83f0a1a28feaa889dd0be7',
    messagingSenderId: '554065461030',
    projectId: 'eventplanning-a11fb',
    storageBucket: 'eventplanning-a11fb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOJiZd-yuis3UWCxpWhQ9OB3Ka1XUdVrk',
    appId: '1:554065461030:ios:be558768d177b046dd0be7',
    messagingSenderId: '554065461030',
    projectId: 'eventplanning-a11fb',
    storageBucket: 'eventplanning-a11fb.appspot.com',
    androidClientId: '554065461030-sa87tr672m8ekg3d78cagmv10bmi1bo4.apps.googleusercontent.com',
    iosClientId: '554065461030-bkntg5a7cujct388kg8sjdltro4rllrh.apps.googleusercontent.com',
    iosBundleId: 'com.example.eventPlanner',
  );
}
