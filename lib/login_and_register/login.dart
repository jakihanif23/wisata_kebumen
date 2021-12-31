import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wisata_kebumen/homepage2.dart';
import 'package:wisata_kebumen/login_and_register/auth_service.dart';
import 'package:wisata_kebumen/login_and_register/register.dart';
import 'package:wisata_kebumen/login_and_register/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();

  //LoginTest
  static Future<User?> loginTest(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print('No User Found with that email');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: logo(),
                    ),
                    Center(
                      child: Text(
                        'Login',
                        style: GoogleFonts.openSans(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email',
                          style: GoogleFonts.lato(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    offset: Offset(0, 3))
                              ]),
                          height: 60,
                          child: TextField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.black38),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter Your Email',
                                hintStyle: GoogleFonts.lato()),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Password',
                          style: GoogleFonts.lato(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    offset: Offset(0, 3))
                              ]),
                          height: 60,
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            style: TextStyle(color: Colors.black38),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                hintText: 'Masukkan Password',
                                hintStyle: GoogleFonts.lato()),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            User? user = await loginTest(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context);
                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage2()));
                              print(user);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Email/Password salah, silahkan masukkan kembali'),
                                duration: Duration(seconds: 5),
                              ));
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                          child: Text(
                            'Login',
                            style: GoogleFonts.openSans(fontSize: 20),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff69BCFC)),
                              shape: MaterialStateProperty.all<StadiumBorder>(
                                  StadiumBorder())),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Or'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  child: IconButton(
                                onPressed: () async {
                                  try{
                                    await authService.signInGoogle().then((value) async {
                                      var FLUser = FirebaseAuth.instance.currentUser;
                                      var FUser = FLUser!.uid;
                                      var auth = FirebaseFirestore.instance.collection('users').doc(FUser);
                                      await auth.set({
                                        'uid' : FUser,
                                        'nama' : FLUser.displayName,
                                        'email' : FLUser.email,
                                      });
                                      print(FUser);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage2()));
                                    });
                                  } catch(e){
                                    print(e.toString());
                                  }
                                },
                                icon: Image.network(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png'),
                                iconSize: 50,
                              )),
                              Container(
                                  child: IconButton(
                                onPressed: () {
                                  print('Facebook Sign In');
                                },
                                icon: Image.network(
                                    'https://image.similarpng.com/very-thumbnail/2020/04/Popular-facebook-Logo-png.png'),
                                iconSize: 50,
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Didn't Have an Account Yet?"),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                              },
                              child: Text('Sign Up'))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
