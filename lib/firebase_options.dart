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
    apiKey: 'AIzaSyDXaVL5Atlzi-8b383dqphudaVYR-Uckk4',
    appId: '1:516102247261:web:1451b4373881e0b3e6ceb4',
    messagingSenderId: '516102247261',
    projectId: 'carozone-58fa1',
    authDomain: 'carozone-58fa1.firebaseapp.com',
    storageBucket: 'carozone-58fa1.appspot.com',
    measurementId: 'G-YSCLHMBKJH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQj-fwNFuxOajaUB-6kH_FxqY_S5P1rbw',
    appId: '1:516102247261:android:9c509996ecef8b69e6ceb4',
    messagingSenderId: '516102247261',
    projectId: 'carozone-58fa1',
    storageBucket: 'carozone-58fa1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCHi5MNtqxHD0DnoaT1xuTOJxWRn3yYKwQ',
    appId: '1:516102247261:ios:c7ec37ef55c46d50e6ceb4',
    messagingSenderId: '516102247261',
    projectId: 'carozone-58fa1',
    storageBucket: 'carozone-58fa1.appspot.com',
    iosBundleId: 'com.example.carOZone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCHi5MNtqxHD0DnoaT1xuTOJxWRn3yYKwQ',
    appId: '1:516102247261:ios:16b68579616f373de6ceb4',
    messagingSenderId: '516102247261',
    projectId: 'carozone-58fa1',
    storageBucket: 'carozone-58fa1.appspot.com',
    iosBundleId: 'com.example.carOZone.RunnerTests',
  );
}