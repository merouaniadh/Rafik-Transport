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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAx-wN_s2v-7b9eUH5gW5bdnkyXiVEWc38',
    appId: '1:163687543330:web:d6c25e91aa4ab10915507b',
    messagingSenderId: '163687543330',
    projectId: 'rafikfire-4600d',
    authDomain: 'rafikfire-4600d.firebaseapp.com',
    storageBucket: 'rafikfire-4600d.appspot.com',
    measurementId: 'G-7KXF2209LX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrdXqiZ60faInGYojfe2yoV6VD6Xh-JR0',
    appId: '1:163687543330:android:73b998370347d88a15507b',
    messagingSenderId: '163687543330',
    projectId: 'rafikfire-4600d',
    storageBucket: 'rafikfire-4600d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCVUbwGPcazYydaimMZ39MGHlZ9k4T60p8',
    appId: '1:163687543330:ios:0a5c95edc9ba37b115507b',
    messagingSenderId: '163687543330',
    projectId: 'rafikfire-4600d',
    storageBucket: 'rafikfire-4600d.appspot.com',
    iosClientId: '163687543330-s0a4unolfb7ogqmehpa9r7b67rbh9mdb.apps.googleusercontent.com',
    iosBundleId: 'com.example.rafik',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCVUbwGPcazYydaimMZ39MGHlZ9k4T60p8',
    appId: '1:163687543330:ios:8bfe5da5c5833e3215507b',
    messagingSenderId: '163687543330',
    projectId: 'rafikfire-4600d',
    storageBucket: 'rafikfire-4600d.appspot.com',
    iosClientId: '163687543330-esh4fdqitdq3mnm4envf27iksgrulspd.apps.googleusercontent.com',
    iosBundleId: 'com.example.rafik.RunnerTests',
  );
}