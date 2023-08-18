import 'package:flutter/material.dart';
import 'package:otobuskalkfirebase/firebase_service.dart'; 
import 'package:otobuskalkfirebase/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'İlçe Otobüs Saatleri',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const SplashScreen(), // Yeni sayfayı çağırın
    );
  }
}

