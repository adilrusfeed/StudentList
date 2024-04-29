import 'package:student/models/student.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/homepage.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      home: HomePage(),
    );
  }
}
