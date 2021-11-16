import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailRestoran extends StatelessWidget {

  DetailRestoran({required this.index});
  final String index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('restoran').doc(index).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var restoranDocument = snapshot.data;
        return Scaffold(
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Text(restoranDocument!['nama']),
                  SizedBox(height: 20),
                  Text(restoranDocument['description'])
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
