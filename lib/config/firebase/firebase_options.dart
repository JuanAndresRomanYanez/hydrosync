// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCvvrCpYagTfUhJ3xTbehs7OGyCvCucYKk',
    appId: '1:316511574032:web:e051ab687697dfeb741295',
    messagingSenderId: '316511574032',
    projectId: 'iot-hidroponia-6a32a',
    authDomain: 'iot-hidroponia-6a32a.firebaseapp.com',
    databaseURL: 'https://iot-hidroponia-6a32a-default-rtdb.firebaseio.com',
    storageBucket: 'iot-hidroponia-6a32a.appspot.com',
    measurementId: 'G-6K0XDE7VCQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDFycWLqtcZSkBfZuTYssuJcim5rxllOFs',
    appId: '1:316511574032:android:e97772bf0c9a36f9741295',
    messagingSenderId: '316511574032',
    projectId: 'iot-hidroponia-6a32a',
    databaseURL: 'https://iot-hidroponia-6a32a-default-rtdb.firebaseio.com',
    storageBucket: 'iot-hidroponia-6a32a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDEm9nC5ueMx7FbrXP5HJ-9lnnv7mwMwkQ',
    appId: '1:316511574032:ios:f466690dabb7ac60741295',
    messagingSenderId: '316511574032',
    projectId: 'iot-hidroponia-6a32a',
    databaseURL: 'https://iot-hidroponia-6a32a-default-rtdb.firebaseio.com',
    storageBucket: 'iot-hidroponia-6a32a.appspot.com',
    iosBundleId: 'com.example.hydrosync',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDEm9nC5ueMx7FbrXP5HJ-9lnnv7mwMwkQ',
    appId: '1:316511574032:ios:f466690dabb7ac60741295',
    messagingSenderId: '316511574032',
    projectId: 'iot-hidroponia-6a32a',
    databaseURL: 'https://iot-hidroponia-6a32a-default-rtdb.firebaseio.com',
    storageBucket: 'iot-hidroponia-6a32a.appspot.com',
    iosBundleId: 'com.example.hydrosync',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCvvrCpYagTfUhJ3xTbehs7OGyCvCucYKk',
    appId: '1:316511574032:web:554f06778f9e2b0d741295',
    messagingSenderId: '316511574032',
    projectId: 'iot-hidroponia-6a32a',
    authDomain: 'iot-hidroponia-6a32a.firebaseapp.com',
    databaseURL: 'https://iot-hidroponia-6a32a-default-rtdb.firebaseio.com',
    storageBucket: 'iot-hidroponia-6a32a.appspot.com',
    measurementId: 'G-F75HLXD5D3',
  );
}