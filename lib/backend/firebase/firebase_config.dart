import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAebCnLlNwT7i_F8JozsTAzRZY4ZdSKuO0",
            authDomain: "orga-event.firebaseapp.com",
            projectId: "orga-event",
            storageBucket: "orga-event.appspot.com",
            messagingSenderId: "586822939324",
            appId: "1:586822939324:web:367bc6952792839c1d16b9",
            measurementId: "G-H34FPKVJFX"));
  } else {
    await Firebase.initializeApp();
  }
}
