import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/googlesignin/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FlutterFire Sample",
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(primarySwatch: Colors.indigo, brightness: Brightness.dark),
      home: SignInScreen(),
    );
  }
}
