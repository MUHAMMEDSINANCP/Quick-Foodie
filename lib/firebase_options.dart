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
    apiKey: 'AIzaSyDtqpcsm7RVD5oFuvPrsE7oZ0mgpGClPy8',
    appId: '1:611694559944:web:9649dd990739efc02cdbfd',
    messagingSenderId: '611694559944',
    projectId: 'quick-foodie-2abd5',
    authDomain: 'quick-foodie-2abd5.firebaseapp.com',
    storageBucket: 'quick-foodie-2abd5.appspot.com',
    measurementId: 'G-Y09E5YPSP6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKePQbZFcZQ_V10mo3CS5BOubijkayXdI',
    appId: '1:611694559944:android:9ab656d5ceed50152cdbfd',
    messagingSenderId: '611694559944',
    projectId: 'quick-foodie-2abd5',
    storageBucket: 'quick-foodie-2abd5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAu-Jmjqcfa2M_CKYkmcEmQx5mg_4b3SMU',
    appId: '1:611694559944:ios:1a606a280e99564a2cdbfd',
    messagingSenderId: '611694559944',
    projectId: 'quick-foodie-2abd5',
    storageBucket: 'quick-foodie-2abd5.appspot.com',
    iosBundleId: 'com.example.foodOnWheel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAu-Jmjqcfa2M_CKYkmcEmQx5mg_4b3SMU',
    appId: '1:611694559944:ios:d807050bd81aa6c72cdbfd',
    messagingSenderId: '611694559944',
    projectId: 'quick-foodie-2abd5',
    storageBucket: 'quick-foodie-2abd5.appspot.com',
    iosBundleId: 'com.example.foodOnWheel.RunnerTests',
  );
}