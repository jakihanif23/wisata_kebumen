import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/model_and_maps/model.dart';
import 'package:wisata_kebumen/hotel/detailhotel.dart';
import 'package:wisata_kebumen/restoran/detailrestoran.dart';
import 'package:wisata_kebumen/wisata/detailwisata.dart';

class NewHomepage extends StatefulWidget {

  @override
  State<NewHomepage> createState() => _NewHomepageState();
}

class _NewHomepageState extends State<NewHomepage> {

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
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text('Wisata', style: TextStyle(fontSize: 15),),
                  ),
                  StreamBuilder(
                    stream: _stream.getStreamWisata(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        height: 180,
                        margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                        width: MediaQuery.of(context).size.width,
                        child: PageView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((e){
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context)=>DetailWisata(index: e['nama'],))
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 5, left: 5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff69BCFC), width: 3),
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          e['foto']
                                        ),
                                      fit: BoxFit.fill
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 15,
                                        left: 13,
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(4.8),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaY: 10, sigmaX: 10),
                                            child: Container(
                                              height: 30,
                                              padding: EdgeInsets.only(left: 5, right: 8),
                                              alignment:
                                              Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.fmd_good, color: Colors.white,),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    e['nama'],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    })
                ],
              ),
              //Restoran
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text('Restoran', style: TextStyle(fontSize: 15),),
                  ),
                  StreamBuilder(
                      stream: _stream.getStreamRestoran(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 180,
                          margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                          width: MediaQuery.of(context).size.width,
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data!.docs.map((e){
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>DetailRestoran(index: e['nama'],))
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff69BCFC), width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              e['foto']
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          bottom: 15,
                                          left: 13,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(4.8),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaY: 10, sigmaX: 10),
                                              child: Container(
                                                height: 30,
                                                padding: EdgeInsets.only(left: 5, right: 8),
                                                alignment:
                                                Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.fmd_good, color: Colors.white,),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      e['nama'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      })
                ],
              ),
              //Hotel
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Text('Hotel', style: TextStyle(fontSize: 15),),
                  ),
                  StreamBuilder(
                      stream: _stream.getStreamHotel(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 180,
                          margin: EdgeInsets.only(top: 8, left: 5, right: 5),
                          width: MediaQuery.of(context).size.width,
                          child: PageView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data!.docs.map((e){
                              return InkWell(
                                onTap: (){
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context)=>DetailHotel(index: e['nama'],))
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xff69BCFC), width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider(
                                              e['foto']
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          bottom: 15,
                                          left: 13,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(4.8),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaY: 10, sigmaX: 10),
                                              child: Container(
                                                height: 30,
                                                padding: EdgeInsets.only(left: 5, right: 8),
                                                alignment:
                                                Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.fmd_good, color: Colors.white,),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      e['nama'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          fontSize: 13),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      })
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
