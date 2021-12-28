import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_kebumen/login_and_register/login.dart';
import 'package:wisata_kebumen/login_and_register/widget.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

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
          loginButton(),
          SizedBox(height: 10,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an Account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text('Sign In'))
              ],
            ),
          )
          ],
        ),
      ),
    ),);
  }
}
