import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wisata_kebumen/login_and_register/login.dart';
import 'package:wisata_kebumen/mainpage.dart';

class Account extends StatefulWidget {
  

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  TextEditingController namacontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();

  String nama = '';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Column(
              children: [
                Center(
                  child: Container(
                    width: 311,
                    height: 197,
                    decoration: BoxDecoration(
                      color: Color(0xff69BCFC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Color(0xff69BCFC), size: 60,),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user == null){
                              return Text('Name', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),);
                            } else{
                              return Text(user.displayName.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),);
                            }
                          }
                        ),
                        Builder(
                          builder: (context) {
                            User? user = FirebaseAuth.instance.currentUser;
                            if (user == null){
                              return Text('email@email.com',style: TextStyle(fontSize: 20, color: Colors.white),);
                            } else{
                              return Text(user.email.toString(),style: TextStyle(fontSize: 20, color: Colors.white),);
                            }

                          }
                        )
                      ],
                    )
                  ),
                ),
                SizedBox(height: 50,),
                InkWell(
                  child: Container(
                    height: 70,
                    width: 311,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xff69BCFC))
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Color(0xff69BCFC),),
                        SizedBox(width: 20,),
                        Text('Edit Profile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                  onTap: (){
                    User? user = FirebaseAuth.instance.currentUser;
                    namacontroller.text = user!.displayName.toString();
                    emailcontroller.text = user.email.toString();
                    if (user == null) {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Komentar'),
                              content: Text('Anda Belum Login, Silahkan Login Terlebih Dahulu'),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context, 'OK'),
                                    child: Text('Oke'))
                              ],
                            );
                          });
                    }
                    else{
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Edit Profile'),
                              content: SingleChildScrollView(
                                child: Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: namacontroller,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                            hintText: 'Nama User',
                                            labelText: 'Nama User'),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                        controller: emailcontroller,
                                        enabled: false,
                                        decoration: InputDecoration(
                                            hintText: 'Email',
                                            labelText: 'Email'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      setState(() {
                                        nama = namacontroller.text;
                                      });
                                      user.updateDisplayName(namacontroller.text);
                                      var uid = user.uid;
                                      await FirebaseFirestore.instance.collection('users').doc(uid).set({
                                        'nama': nama,
                                        'email': '${user.email}',
                                        'uid': '${uid}'
                                      });
                                      namacontroller.clear();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                            'Berhasil Menambahkan Komentar'),
                                        duration:
                                        Duration(seconds: 5),
                                      ));
                                    },
                                    child: Text('Input'))
                              ],
                            );
                          });
                    }
                  },
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  width: 311,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xff69BCFC))
                  ),
                  child: Builder(
                    builder: (context) {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user == null){
                        return InkWell(
                          onTap:(){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login())
                            );
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.login, color: Color(0xff69BCFC),),
                                SizedBox(width: 20,),
                                Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () async {
                            GoogleSignIn googleUserlogout = await GoogleSignIn();
                            await FirebaseAuth.instance.signOut();
                            googleUserlogout.signOut();
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=>Home())
                            );
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout, color: Color(0xff69BCFC),),
                                SizedBox(width: 20,),
                                Text('Logout', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        );
                      }

                    }
                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ],
        )
      ),
    );
  }
}
