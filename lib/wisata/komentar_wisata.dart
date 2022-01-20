import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class KomentarWisata extends StatefulWidget {
  KomentarWisata({required this.index});
  final String index;
  @override
  _KomentarWisataState createState() => _KomentarWisataState();
}

class _KomentarWisataState extends State<KomentarWisata> {

  var wisataref = FirebaseFirestore.instance.collection('wisata');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: wisataref.doc(widget.index).collection('Komentar').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              // DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
              return Container();
            }
          );
        },
      ),
    );
  }
}
