import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/notesapp/model/notes_model.dart';

import 'splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  var catBox = await Hive.openBox('categories');
  Hive.registerAdapter(NotesModelAdapter());
  var box = await Hive.openBox('noteBox');
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}