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
    apiKey: 'AIzaSyA05HaSTTL1uzxim4UatLuxr_YUkdQdAgQ',
    appId: '1:413485085367:web:026176ca4866541f8a9332',
    messagingSenderId: '413485085367',
    projectId: 'stock-tracker-app-6bdcf',
    authDomain: 'stock-tracker-app-6bdcf.firebaseapp.com',
    storageBucket: 'stock-tracker-app-6bdcf.firebasestorage.app',
    measurementId: 'G-L05JYBD2MZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_F80qGm5vAfbrHjTf5Zn7qT0SOm3Yv04',
    appId: '1:413485085367:android:d3b85c1cb8c187f18a9332',
    messagingSenderId: '413485085367',
    projectId: 'stock-tracker-app-6bdcf',
    storageBucket: 'stock-tracker-app-6bdcf.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAxaZjg9AwwTDhjDx9yMzl16CJMFrE5fG4',
    appId: '1:413485085367:ios:e55dd53d7ba991dd8a9332',
    messagingSenderId: '413485085367',
    projectId: 'stock-tracker-app-6bdcf',
    storageBucket: 'stock-tracker-app-6bdcf.firebasestorage.app',
    iosBundleId: 'com.example.stockTrackerApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAxaZjg9AwwTDhjDx9yMzl16CJMFrE5fG4',
    appId: '1:413485085367:ios:e55dd53d7ba991dd8a9332',
    messagingSenderId: '413485085367',
    projectId: 'stock-tracker-app-6bdcf',
    storageBucket: 'stock-tracker-app-6bdcf.firebasestorage.app',
    iosBundleId: 'com.example.stockTrackerApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA05HaSTTL1uzxim4UatLuxr_YUkdQdAgQ',
    appId: '1:413485085367:web:51fcf34ac9c26c0a8a9332',
    messagingSenderId: '413485085367',
    projectId: 'stock-tracker-app-6bdcf',
    authDomain: 'stock-tracker-app-6bdcf.firebaseapp.com',
    storageBucket: 'stock-tracker-app-6bdcf.firebasestorage.app',
    measurementId: 'G-WWY5B5TPDW',
  );
}
