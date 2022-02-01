import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homepage/homepage.dart';
import 'login_and_register/login.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else{
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
      }
    });
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
