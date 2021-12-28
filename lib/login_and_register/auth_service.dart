import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //stream firebaseauth


  //Register
  Future register(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print('Signed Up');
    } catch(e){
      print(e.toString());
      return e;
    }
  }

  //Login
  Future login(String email, String password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print('Logged In');
    } catch(e){
      print(e.toString());
      return e;
    }
  }

  //Logout
  Future logout() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}
