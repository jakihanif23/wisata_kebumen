import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/homepage2.dart';
import 'package:wisata_kebumen/loading.dart';

import 'homepage/homepage.dart';


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
      home: HomePage(),
    );
  }
}
