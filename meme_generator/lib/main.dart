import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meme_generator/home_page.dart';
import 'package:meme_generator/auth_page.dart';
import 'package:meme_generator/select_meme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
      ),
      home: SelectMeme(),
    );
  }
}
