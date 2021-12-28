import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_kebumen/login_and_register/register.dart';
import 'package:path/path.dart' as Path;

Widget logo(){
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Image(
          image: AssetImage('assets/image/wklogo3.png'),
          width: 150,
          height: 150,
        )
      ),
    )
  );
}
Widget insertEmail(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Email',
        style: GoogleFonts.lato(),
      ),
      SizedBox(height: 10,),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  offset: Offset(0,3)
              )
            ]
        ),
        height: 60,
        child: TextField(
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
              hintStyle: GoogleFonts.lato()
          ),
        ),
      )
    ],
  );
}

Widget insertPassword(){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Password',
        style: GoogleFonts.lato(),
      ),
      SizedBox(height: 10,),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  offset: Offset(0,3)
              )
            ]
        ),
        height: 60,
        child: TextField(
          obscureText: true,
          style: TextStyle(color: Colors.black38),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Enter Your Password',
              hintStyle: GoogleFonts.lato()
          ),
        ),
      )
    ],
  );
}

Widget loginButton(){
  return Center(
    child: Container(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () {print('Login Button Pressed');},
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
  );
}

/*Widget signUpWidget(){
  return Container(
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
  );
}*/