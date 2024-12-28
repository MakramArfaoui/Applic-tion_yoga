import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD9G0QI2CZBebre-MLB7HMA2Lf7C_0_oQ4',
    appId: '1:370617044450:web:8971d2e13e5de4f416fdbb',
    messagingSenderId: '370617044450',
    projectId: 'yogaapp-199e5',
    authDomain: 'yogaapp-199e5.firebaseapp.com',
    storageBucket: 'yogaapp-199e5.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9G0QI2CZBebre-MLB7HMA2Lf7C_0_oQ4',
    appId: '1:370617044450:android:8971d2e13e5de4f416fdbb',
    messagingSenderId: '370617044450',
    projectId: 'yogaapp-199e5',
    storageBucket: 'yogaapp-199e5.appspot.com',
  );
}
