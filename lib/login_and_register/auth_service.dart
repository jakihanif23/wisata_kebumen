import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //stream firebaseauth


  //Register
  Future register(String email, String password, String nama) async{
    try{
      UserCredential rslt = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      rslt.user!.updateDisplayName(nama);
      print('Signed Up');
    } catch(e){
      print(e.toString());
      return e;
    }
  }

  //Login
  Future login(String email, String password,) async{
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

  //Google Sign In
  Future<UserCredential?> signInGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

}
