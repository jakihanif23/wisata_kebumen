import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/card/ItemCard.dart';

class KomentarHotel extends StatefulWidget {
  KomentarHotel({required this.index});
  final String index;
  @override
  _KomentarHotelState createState() => _KomentarHotelState();
}

class _KomentarHotelState extends State<KomentarHotel> {

  var hotelref = FirebaseFirestore.instance.collection('hotel');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Komentar Hotel ${widget.index}"),
      ),
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: hotelref.doc(widget.index).collection('Komentar').snapshots(),
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
