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
    apiKey: 'AIzaSyDympkOSktHhunVDvKPdqF46sKrMDbixZ4',
    appId: '1:149302232375:web:4c7bb790932498426e86b2',
    messagingSenderId: '149302232375',
    projectId: 'ecommerce-app-c1bdf',
    authDomain: 'ecommerce-app-c1bdf.firebaseapp.com',
    storageBucket: 'ecommerce-app-c1bdf.appspot.com',
    measurementId: 'G-R13LV9CWYY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC5C7h6oS03Pkek7CJEaLCEDBUxsBp5TJ8',
    appId: '1:149302232375:android:9a5a682357500ffa6e86b2',
    messagingSenderId: '149302232375',
    projectId: 'ecommerce-app-c1bdf',
    storageBucket: 'ecommerce-app-c1bdf.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFoKL_MPbqRxL6rUHEs-qUPlvme1Ni2Mg',
    appId: '1:149302232375:ios:5ceaed3aeab9b8696e86b2',
    messagingSenderId: '149302232375',
    projectId: 'ecommerce-app-c1bdf',
    storageBucket: 'ecommerce-app-c1bdf.appspot.com',
    iosBundleId: 'com.example.eCommerceApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFoKL_MPbqRxL6rUHEs-qUPlvme1Ni2Mg',
    appId: '1:149302232375:ios:5ceaed3aeab9b8696e86b2',
    messagingSenderId: '149302232375',
    projectId: 'ecommerce-app-c1bdf',
    storageBucket: 'ecommerce-app-c1bdf.appspot.com',
    iosBundleId: 'com.example.eCommerceApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDympkOSktHhunVDvKPdqF46sKrMDbixZ4',
    appId: '1:149302232375:web:dc63df7851ef1c846e86b2',
    messagingSenderId: '149302232375',
    projectId: 'ecommerce-app-c1bdf',
    authDomain: 'ecommerce-app-c1bdf.firebaseapp.com',
    storageBucket: 'ecommerce-app-c1bdf.appspot.com',
    measurementId: 'G-8ND92PQJL5',
  );
}
