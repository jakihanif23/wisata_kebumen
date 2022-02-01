import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/card/ItemCard.dart';

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
      appBar: AppBar(
        title: Text("Komentar Wisata ${widget.index}"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: wisataref.doc(widget.index).collection('Komentar').snapshots(),
            builder: (_,snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else{
                var wasd = snapshot.data!.docs.length;
                print(wasd);
                return Column(
                  children: snapshot.data!.docs
                      .map((e) =>
                      ItemCard(e['nama_user'], e['rating'], e['komentar'])
                  ).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
