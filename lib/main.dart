import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notes_application/models/notes_model.dart';

import 'pages/home_page.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Note>(NoteAdapter());
  box = await Hive.openBox<Note>('Note');
  // box.add(
  //   Note(
  //     title: 'محمد ابراهيم',
  //     note: 'انا اسمي محمد ابراهيم',
  //     creationDate: DateTime.now(),
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
