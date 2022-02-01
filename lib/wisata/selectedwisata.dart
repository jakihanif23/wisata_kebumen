import 'dart:ffi';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wisata_kebumen/model_and_maps/google_maps.dart';
import 'package:wisata_kebumen/wisata/komentar_wisata.dart';

class SelectedWisata extends StatefulWidget {
  SelectedWisata({required this.index});

  final String index;

  @override
  State<SelectedWisata> createState() => _SelectedWisataState();
}

class _SelectedWisataState extends State<SelectedWisata> {
  final _pageController = PageController();
  double rating = 0;
  final komentarController = TextEditingController();
  String komen = "";
  TextEditingController _ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var wisataRef = FirebaseFirestore.instance.collection('wisata');
    return StreamBuilder(
      stream: wisataRef.doc(widget.index).snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var wisataDoc = snapshot.data;
        List<dynamic> pictures = wisataDoc!['pictures'];
        final kom = wisataRef.doc(widget.index).collection('Komentar');
        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  Container(
                    height: 320,
                    child: ListView.builder(
                        itemCount: pictures.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, images) {
                          return Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      pictures[images], scale: 0.1),
                                )
                            ),
                          );
                        }
                    ),
                  ),
                  Text(wisataDoc['nama']),
                  SizedBox(height: 20,),
                  // RatingBarIndicator(
                  //     itemCount: 5,
                  //     rating: double.parse(wisataDoc['rating']),
                  //     itemBuilder: (context, _) =>
                  //         Icon(Icons.star, color: Colors.amber,)
                  // ),
                  // SizedBox(height: 10,),
                  StreamBuilder<QuerySnapshot>(
                    stream: kom.snapshots(),
                    builder: (_, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Rating 0.0");
                      } else {
                        var co = snapshot.data!.docs;
                        var wasd = co.length;
                        var rat = co.map((e) => e['rating']).toList();
                        double sum = rat.fold(0, (p, c) => p + c);
                        var hasil = sum / wasd;
                        return Container(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          KomentarWisata(
                                            index: wisataDoc['nama'],)));
                                },
                                child: RatingBarIndicator(
                                    itemCount: 5,
                                    rating: hasil,
                                    itemBuilder: (context, _) {
                                      return Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      );
                                    }
                                ),
                              ),
                              Text('Rating ${hasil.toString()}')
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  // Text(
                  //   'Rating: ${wisataDoc['rating']}',
                  // ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text(
                      wisataDoc['description'], textAlign: TextAlign.justify,),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        KomentarWisata(
                                          index: wisataDoc['nama'],)));
                              },
                              child: Text('tampil komentar')
                          ),
                          ElevatedButton(
                            onPressed: () {
                              User? user = FirebaseAuth.instance.currentUser;
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    double wasd = 0.0;
                                    return AlertDialog(
                                      title: Text('Komentar'),
                                      content: SingleChildScrollView(
                                        child: Container(
                                          height: 200,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller:
                                                komentarController,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                    hintText:
                                                    'Masukkan Komentar',
                                                    labelText:
                                                    'Masukkan Komentar'),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              RatingBar.builder(
                                                  initialRating: this.rating,
                                                  minRating: 1,
                                                  updateOnDrag: true,
                                                  allowHalfRating: true,
                                                  itemBuilder: (context,
                                                      _) =>
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  onRatingUpdate:
                                                      (rating) =>
                                                      setState(() {
                                                        this.rating = rating;
                                                      })),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              setState(() {
                                                komen =
                                                    komentarController.text;
                                              });
                                              wisataRef
                                                  .doc(widget.index)
                                                  .collection('Komentar')
                                                  .doc(user!.uid)
                                                  .set({
                                                'nama_user':
                                                '${user.displayName}',
                                                'uid': '${user.uid}',
                                                'komentar': '${komen}',
                                                'rating': this.rating
                                              });
                                              komentarController.clear();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Berhasil Menambahkan Komentar'),
                                                duration:
                                                Duration(seconds: 5),
                                              ));
                                            },
                                            child: Text('Input'))
                                      ],
                                    );
                                  });
                            },
                            child: Text('tambah komentar'),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) {
                                        print(wisataDoc['lat']);
                                        print(wisataDoc['lang']);
                                        return MapSample(
                                          index: wisataDoc['lat'],
                                          index1: wisataDoc['lang'],
                                          index2: wisataDoc['nama'],);
                                      }));
                            },
                            child: Text('Location'),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
