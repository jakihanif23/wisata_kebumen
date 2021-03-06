import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:wisata_kebumen/card/ItemCard.dart';
import 'package:wisata_kebumen/model_and_maps/google_maps.dart';


class DetailRestoran extends StatefulWidget {
  DetailRestoran({required this.index});
  final String index;

  @override
  _DetailRestoranState createState() => _DetailRestoranState();
}

class _DetailRestoranState extends State<DetailRestoran> {
  final komentarController = TextEditingController();
  double rating = 0;
  String komen = "";
  var restoranRef = FirebaseFirestore.instance.collection('restoran');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: restoranRef.doc(widget.index).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var restoranDoc = snapshot.data;
          List<dynamic> pictures = restoranDoc!['pictures'];
          final kom = restoranRef.doc(widget.index).collection('Komentar');
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        //Image ListView
                        Container(
                          height: MediaQuery.of(context).size.height *0.45,
                          child: ListView.builder(
                              itemCount: pictures.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, images) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              pictures[images], scale: 1.0),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                );
                              }
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //back button
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 50, left: 10),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                      color: Colors.black26.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Icon(Icons.arrow_back, color: Colors.white,),
                                ),
                              ),
                            ),
                            //maps button
                            Container(
                              alignment: Alignment.bottomRight,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.347,
                              child: InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>MapSample(index: restoranDoc['lat'], index1: restoranDoc['lang'], index2: restoranDoc['nama']))
                                  );
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(top: 50, left: 10, right: 10, bottom: 25),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(0xff69BCFC),
                                        borderRadius: BorderRadius.circular(50)
                                    ),
                                    child: Icon(Icons.fmd_good_rounded, color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text(
                      restoranDoc['nama'],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBarIndicator(
                                        itemSize: 25,
                                        itemCount: 5,
                                        rating: hasil,
                                        itemBuilder: (context, _) {
                                          return Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        }
                                    ),
                                    SizedBox(width: 10,),
                                    Text(hasil.toString().substring(0,3), style: TextStyle(fontSize: 15),)
                                  ],
                                ),
                                SizedBox(height: 5,),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 30),
                            height: MediaQuery.of(context).size.height *0.44,
                            child: TabBarView(
                              children: [
                                //deskripsi page
                                Container(
                                  padding: EdgeInsets.only(top : 10,left: 20, right: 25, bottom: 20),
                                  child: ListView(
                                    padding: EdgeInsets.only(top: 5),
                                    children: [
                                      Text(
                                        '\b\b\b\b\b\b${restoranDoc['description']}',
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            height: 1.4
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //harga page
                                Container(
                                    padding: EdgeInsets.only(top : 17,left: 20, right: 25, bottom: 20),
                                    child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black
                                          ),
                                          children: [
                                            TextSpan(
                                                text: 'Untuk Harga Dari Makanan Disini Dimulai Dari Harga \n\n'
                                            ),
                                            TextSpan(
                                              text: 'Rp. ${restoranDoc['harga']}'
                                            )
                                          ]
                                      ),
                                    )
                                ),
                                // komentar page
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: ListView(
                                    padding: EdgeInsets.only(top: 5),
                                    children: [
                                      StreamBuilder<QuerySnapshot>(
                                        stream: restoranRef.doc(widget.index).collection('Komentar').snapshots(),
                                        builder: (_,snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                              child: CircularProgressIndicator(),
                                            );
                                          } else{
                                            return Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                                                  child: ElevatedButton(
                                                    onPressed: (){
                                                      User? user = FirebaseAuth.instance.currentUser;
                                                      kom.where('uid', isEqualTo: user!.uid).get().then((QuerySnapshot querySnapshot) {
                                                        querySnapshot.docs.forEach((element) {
                                                          if(element['uid'] == null){
                                                            showDialog(
                                                                context: context,
                                                                builder: (context){
                                                                  return AlertDialog(
                                                                    title: Text('Komentar'),
                                                                    content: Text('Anda Belum Login, Silahkan Login Terlebih Dahulu'),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed: () => Navigator.pop(context, 'OK'),
                                                                          child: Text('Oke'))
                                                                    ],
                                                                  );
                                                                });
                                                          }
                                                          komen = element['komentar'] ?? '';
                                                          rating = element['rating'] ?? 0.0;
                                                          komentarController.text = komen;
                                                        });
                                                      });
                                                      if (user == null) {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context){
                                                              return AlertDialog(
                                                                title: Text('Komentar'),
                                                                content: Text('Anda Belum Login, Silahkan Login Terlebih Dahulu'),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed: () => Navigator.pop(context, 'OK'),
                                                                      child: Text('Oke'))
                                                                ],
                                                              );
                                                            });
                                                      }else{
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
                                                                        Navigator.pop(context);
                                                                        setState(() {
                                                                          komen = komentarController.text;
                                                                        });
                                                                        restoranRef
                                                                            .doc(widget.index)
                                                                            .collection('Komentar')
                                                                            .doc(user.uid)
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
                                                      }
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.add_comment),
                                                        SizedBox(width: 5,),
                                                        Text('Tambahkan Komentar')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  children: snapshot.data!.docs.map<Widget>((e) => ItemCard(e['nama_user'], e['rating'], e['komentar'])).toList(),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              margin: EdgeInsets.only(left: 10, top: 5),
                              child: TabBar(
                                labelPadding: EdgeInsets.only(left: 10, right: 14.4),
                                indicatorPadding: EdgeInsets.only(left: 10, right: 14.4),
                                isScrollable: true,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.black38,
                                indicator: MaterialIndicator(
                                    bottomRightRadius: 5,
                                    bottomLeftRadius: 5,
                                    topLeftRadius: 5,
                                    topRightRadius: 5,
                                    horizontalPadding: 12),
                                tabs: [
                                  Tab(
                                    child: Container(
                                      child: Text('Deskripsi'),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Text('Harga'),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Text('Komentar'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
