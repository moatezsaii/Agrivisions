import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBi9_ivoFgct1gZ7gBHXVID4Dr3cID6v-Y",
            authDomain: "agrivision-a713f.firebaseapp.com",
            projectId: "agrivision-a713f",
            storageBucket: "agrivision-a713f.appspot.com",
            messagingSenderId: "632656962180",
            appId: "1:632656962180:web:2ca1816ccfb67cbe8418d1",
            measurementId: "G-LC9KVZ67PB"));
  } else {
    await Firebase.initializeApp();
  }
}
