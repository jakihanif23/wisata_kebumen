import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_kebumen/login_and_register/auth_service.dart';
import 'package:wisata_kebumen/login_and_register/login.dart';
import 'package:wisata_kebumen/login_and_register/widget.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();

  String email = '';
  String password = '';
  String nama = '';
  final AuthService authService = AuthService();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
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
                          'Sign Up',
                          style: GoogleFonts.openSans(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //textfield nama
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama',
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
                            child: TextFormField(
                              controller: _controller1,
                              validator: (val) =>
                                  val!.isEmpty ? 'Masukkan Nama Anda' : null,
                              onChanged: (val) {
                                nama = val;
                              },
                              keyboardType: TextInputType.name,
                              style: TextStyle(color: Colors.black38),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Masukkan Nama',
                                  hintStyle: GoogleFonts.lato()),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //textfield email
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
                            child: TextFormField(
                              controller: _controller2,
                              validator: (val) =>
                                  val!.isEmpty ? 'Masukkan Email Anda' : null,
                              onChanged: (val) {
                                email = val;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.black38),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Masukkan Email',
                                  hintStyle: GoogleFonts.lato()),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      //password
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
                            child: TextFormField(
                              controller: _controller3,
                              validator: (val) => val!.length < 6
                                  ? 'Password minimal 6 karakter'
                                  : null,
                              onChanged: (val) {
                                password = val;
                              },
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
                              if (_formKey.currentState!.validate()) {
                                _register(email, password);
                                _controller1.clear();
                                _controller2.clear();
                                _controller3.clear();
                                print(auth.currentUser);
                              }
                            },
                            child: Text(
                              'Register',
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
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already Have an Account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Sign In'))
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
      ),
    );
  }

  _register(String _email, String _password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        user!.updateDisplayName(nama);
        var FUser = user.uid;
        await FirebaseFirestore.instance.collection('users').doc(FUser).set({
          'uid': FUser,
          'nama': nama,
          'email': email,
          'password': password,
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Register Berhasil, Silahkan ke Halaman Login'),
          duration: Duration(seconds: 5),
        ));
      });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Registrasi Failed'),
                content: Text('${e.message}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Okay'),
                  )
                ],
              ));
    }
  }
}
