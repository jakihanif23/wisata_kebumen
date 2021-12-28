import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedWisata extends StatefulWidget {
  SelectedWisata({required this.index});
  final String index;

  @override
  State<SelectedWisata> createState() => _SelectedWisataState();
}

class _SelectedWisataState extends State<SelectedWisata> {
  final _pageController = PageController();
  double rating = 2.5;

  @override
  Widget build(BuildContext context) {
    var wisataRef = FirebaseFirestore.instance.collection('wisata');
    var docs = FirebaseFirestore.instance.collection('wisata').doc(widget.index);
    return StreamBuilder(
      stream: wisataRef.doc(widget.index).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var wisataDoc = snapshot.data;
        List<dynamic> pictures = wisataDoc!['pictures'];
        return Scaffold(
          body: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  height: 320,
                  child: ListView.builder(
                    itemCount: pictures.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, images){
                      return Container(
                        width: 400,
                        height: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(pictures[images], scale: 0.1),
                            )
                        ),
                      );
                    }
                  ),
                ),
                Text(wisataDoc['nama']),
                SizedBox(height: 20,),
                RatingBar.builder(
                  initialRating: 2.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  onRatingUpdate: (rating) {
                    print(rating);
                    setState(() {
                      this.rating = rating;
                    });
                  },
                  itemBuilder: (context, _)=>Icon(Icons.star, color: Colors.amber,),
                ),
                Text(
                  'Rating: $rating',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
