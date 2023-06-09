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
    apiKey: 'AIzaSyCyvuwb84xUJTgeqHF5nXeA4VXMNQICr54',
    appId: '1:646408393719:web:2b7c6502ac48653b2154f2',
    messagingSenderId: '646408393719',
    projectId: 'basetcdmx',
    authDomain: 'basetcdmx.firebaseapp.com',
    storageBucket: 'basetcdmx.appspot.com',
    measurementId: 'G-E8HL168XWJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKTIMEcSQ7XeeVKM4-JBTvgWtWJMjy9ac',
    appId: '1:646408393719:android:b78b19310a1673fd2154f2',
    messagingSenderId: '646408393719',
    projectId: 'basetcdmx',
    storageBucket: 'basetcdmx.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXhMePjW8i3cXTEcE7IEYcmHrFYUr7f9w',
    appId: '1:646408393719:ios:f71c49bc7e755d702154f2',
    messagingSenderId: '646408393719',
    projectId: 'basetcdmx',
    storageBucket: 'basetcdmx.appspot.com',
    iosClientId: '646408393719-hlqqmbuat1t32rfkdaveds1ku2cao231.apps.googleusercontent.com',
    iosBundleId: 'com.example.plataformav1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXhMePjW8i3cXTEcE7IEYcmHrFYUr7f9w',
    appId: '1:646408393719:ios:380695183762dc532154f2',
    messagingSenderId: '646408393719',
    projectId: 'basetcdmx',
    storageBucket: 'basetcdmx.appspot.com',
    iosClientId: '646408393719-rmlbtbnvqbmog0aje5fu20u17e9317r7.apps.googleusercontent.com',
    iosBundleId: 'com.example.plataformav1.RunnerTests',
  );
}
