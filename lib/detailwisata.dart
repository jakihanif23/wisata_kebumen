import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailWisata extends StatelessWidget {
  DetailWisata({required this.index});
  final String index;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('wisata').doc(index).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var wisataDocument = snapshot.data;
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Image.network(wisataDocument!['foto']),
                    SizedBox(height: 20),
                    Text(wisataDocument['nama'])
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
