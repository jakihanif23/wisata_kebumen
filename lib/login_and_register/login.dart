import 'dart:async';
import 'dart:convert' show json;

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wisata_kebumen/homepage2.dart';
import 'package:wisata_kebumen/login_and_register/register.dart';
import 'package:wisata_kebumen/login_and_register/widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Container(
                child: logo(),
              ),
              Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.openSans(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                  ),
                ),
              ),
              SizedBox(height: 20,),
              insertEmail(),
              SizedBox(height: 20,),
              insertPassword(),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage2())
                      );
                    },
                    child: Text('Login', style: GoogleFonts.openSans(fontSize: 20),),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff69BCFC)),
                        shape: MaterialStateProperty.all<StadiumBorder>(
                            StadiumBorder(
                            )
                        )
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
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
                            onPressed: (){print('Google sign In');},
                            icon: Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png'
                            ),
                            iconSize: 50,
                          )
                        ),
                        Container(
                            child: IconButton(
                              onPressed: (){print('Facebook Sign In');},
                              icon: Image.network(
                                  'https://image.similarpng.com/very-thumbnail/2020/04/Popular-facebook-Logo-png.png'
                              ),
                              iconSize: 50,
                            )
                        ),
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
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                        },
                        child: Text('Sign Up'))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
