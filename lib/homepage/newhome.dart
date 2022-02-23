import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:wisata_kebumen/card/cardWisata.dart';
import 'package:wisata_kebumen/model_and_maps/model.dart';
import 'package:wisata_kebumen/hotel/detailhotel.dart';
import 'package:wisata_kebumen/restoran/detailrestoran.dart';
import 'package:wisata_kebumen/wisata/detailwisata.dart';

class NewHomepage extends StatefulWidget {

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {

  List<CachedNetworkImageProvider> _listOfImages = <CachedNetworkImageProvider>[];

  final komentarController = TextEditingController();
  double rating = 0;
  String komen = "";

  final _stream = ReadData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //logo dan wisata kebumen
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.27,
                decoration: BoxDecoration(
                  color: Color(0xff69BCFC),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/image/wklogo3.png', color: Colors.white,),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Text('Wisata Kebumen', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 15,),
          //wisata, restoran, hotel
          Column(
            children: [
              //Wisata
              Column(
                children: [
                  DefaultTabController(
                    length: 4,
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          height: MediaQuery.of(context).size.height *0.562,
                          child: TabBarView(
                            children: [
                              //Objek Wisata
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: StreamBuilder(
                                    stream: _stream.getStreamWisata(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container(
                                        height: 350,
                                        margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context, int index){
                                            DocumentSnapshot ba = snapshot.data!.docs[index];
                                            return InkWell(
                                              child: CardWisata(
                                                  ba['foto'],
                                                  ba['nama']
                                              ),
                                              onTap: (){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context)=>DetailWisata(index: ba['nama']))
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              //Desa Wisata
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: StreamBuilder(
                                    stream: _stream.getStreamWisata(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container(
                                        height: 350,
                                        margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context, int index){
                                            DocumentSnapshot ba = snapshot.data!.docs[index];
                                            return InkWell(
                                              child: CardWisata(
                                                  ba['foto'],
                                                  ba['nama']
                                              ),
                                              onTap: (){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context)=>DetailWisata(index: ba['nama']))
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              //Restoran
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: StreamBuilder(
                                    stream: _stream.getStreamRestoran(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container(
                                        height: 350,
                                        margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context, int index){
                                            DocumentSnapshot ba = snapshot.data!.docs[index];
                                            return InkWell(
                                              child: CardWisata(
                                                  ba['foto'],
                                                  ba['nama']
                                              ),
                                              onTap: (){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context)=>DetailRestoran(index: ba['nama']))
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }),
                              ),
                              //Hotel
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: StreamBuilder(
                                    stream: _stream.getStreamHotel(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                      if (!snapshot.hasData) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      return Container(
                                        height: 350,
                                        margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                                        width: MediaQuery.of(context).size.width,
                                        child: ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: (BuildContext context, int index){
                                            DocumentSnapshot ba = snapshot.data!.docs[index];
                                            return InkWell(
                                              child: CardWisata(
                                                  ba['foto'],
                                                  ba['nama']
                                              ),
                                              onTap: (){
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(builder: (context)=>DetailHotel(index: ba['nama']))
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            alignment: Alignment.topCenter,
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
                                    child: Text('Objek Wisata'),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    child: Text('Desa Wisata'),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    child: Text('Restoran'),
                                  ),
                                ),
                                Tab(
                                  child: Container(
                                    child: Text('Hotel'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   child: StreamBuilder(
                  //       stream: _stream.getStreamWisata(),
                  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  //         if (!snapshot.hasData) {
                  //           return Center(
                  //             child: CircularProgressIndicator(),
                  //           );
                  //         }
                  //         return Container(
                  //           height: 350,
                  //           margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                  //           width: MediaQuery.of(context).size.width,
                  //           child: ListView.builder(
                  //             itemCount: snapshot.data!.docs.length,
                  //             itemBuilder: (BuildContext context, int index){
                  //               DocumentSnapshot ba = snapshot.data!.docs[index];
                  //               return InkWell(
                  //                 child: CardWisata(
                  //                     ba['foto'],
                  //                     ba['nama']
                  //                 ),
                  //                 onTap: (){
                  //                   Navigator.of(context).push(
                  //                       MaterialPageRoute(builder: (context)=>DetailWisata(index: ba['nama']))
                  //                   );
                  //                 },
                  //               );
                  //             },
                  //           ),
                  //         );
                  //       }),
                  // )
                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ],
      ),
    );
  }
}
