import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/ItemCard.dart';

class KomentarRestoran extends StatefulWidget {
  KomentarRestoran({required this.index});
  final String index;
  @override
  _KomentarRestoranState createState() => _KomentarRestoranState();
}

class _KomentarRestoranState extends State<KomentarRestoran> {

  var restoranref = FirebaseFirestore.instance.collection('restoran');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Komentar Restoran ${widget.index}"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: restoranref.doc(widget.index).collection('Komentar').snapshots(),
            builder: (_,snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else{
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
