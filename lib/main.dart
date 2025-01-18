import 'package:flutter/material.dart';
import 'package:to_do_app/screens/intro_screen.dart';
import 'package:to_do_app/screens/task_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter("my_hive_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: 'intro',
      routes: {
        'intro': (context) => IntroPage(),
        'task': (context) => TasksPage(),
      },
    );
  }
}
