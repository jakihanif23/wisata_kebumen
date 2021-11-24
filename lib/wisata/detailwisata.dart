import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/wisata/wisatamodel.dart';

class DetailWisata extends StatefulWidget {
  DetailWisata({required this.index});
  final String index;

  @override
  State<DetailWisata> createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('wisata').doc(widget.index).snapshots(),
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
                    Text(wisataDocument['nama']),
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
