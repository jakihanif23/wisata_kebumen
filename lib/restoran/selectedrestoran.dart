import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:wisata_kebumen/maps_test.dart';
import 'package:wisata_kebumen/wisata/komentar_wisata.dart';

class SelectedRestoran extends StatefulWidget {
  SelectedRestoran({required this.index});
  final String index;

  @override
  State<SelectedRestoran> createState() => _SelectedRestoranState();
}

class _SelectedRestoranState extends State<SelectedRestoran> {
  double rating = 0.0;
  final komentarController = TextEditingController();
  String komen = "";

  @override
  Widget build(BuildContext context) {
    var restoranRef = FirebaseFirestore.instance.collection('restoran');
    return StreamBuilder(
      stream: restoranRef.doc(widget.index).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var restoranDoc = snapshot.data;
        List<dynamic> pictures = restoranDoc!['pictures'];
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
                  Text(restoranDoc['nama']),
                  SizedBox(height: 20,),
                  RatingBarIndicator(
                      itemCount: 5,
                      rating: double.parse(restoranDoc['rating']),
                      itemBuilder: (context, _)=>Icon(Icons.star, color: Colors.amber,)
                  ),
                  Text(
                    'Rating: ${restoranDoc['rating']}',
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Text(restoranDoc['description'], textAlign: TextAlign.justify,),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>KomentarWisata(index: restoranDoc['nama'],)));
                              },
                              child: Text('tampil komentar')
                          ),
                          ElevatedButton(
                            onPressed: (){
                              User? user = FirebaseAuth.instance.currentUser;
                              showDialog(
                                  context: context,
                                  builder: (context)=>AlertDialog(
                                    title: Text('Komentar'),
                                    content: SingleChildScrollView(
                                      child: Container(
                                        height: 200,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: komentarController,
                                              autofocus: true,
                                              decoration: InputDecoration(
                                                  hintText: 'Masukkan Komentar',
                                                  labelText: 'Masukkan Komentar'
                                              ),
                                            ),
                                            SizedBox(height: 30,),
                                            RatingBar.builder(
                                                initialRating: rating,
                                                minRating: 1,
                                                updateOnDrag: true,
                                                allowHalfRating: true,
                                                itemBuilder: (context,_)=> Icon(Icons.star, color: Colors.amber,),
                                                onRatingUpdate: (rating) => setState(() {
                                                  this.rating = rating;
                                                })
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            setState(() {
                                              komen = komentarController.text;
                                            });
                                            restoranRef.doc(widget.index).collection('Komentar').doc(user!.uid).set(
                                                {
                                                  'nama_user': '${user.displayName}',
                                                  'uid': '${user.uid}',
                                                  'komentar': '${komen}',
                                                  'rating': '$rating'
                                                }
                                            );
                                            komentarController.clear();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text('Berhasil Menambahkan Komentar'),
                                              duration: Duration(seconds: 5),
                                            ));
                                          },
                                          child: Text('Input'))
                                    ],
                                  )
                              );
                            },
                            child: Text('tambah komentar'),
                          ),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context){
                                        print(restoranDoc['lat']);
                                        print(restoranDoc['lang']);
                                        return MapSample(index: restoranDoc['lat'], index1: restoranDoc['lang'], index2: restoranDoc['nama'],);
                                        return MapSample(index: restoranDoc['lat'], index1: restoranDoc['lang'], index2: restoranDoc['nama'],);
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
