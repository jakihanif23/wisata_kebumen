import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedWisata extends StatelessWidget {
  SelectedWisata({required this.index});
  final String index;
  final _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    var wisataRef = FirebaseFirestore.instance.collection('wisata');
    var docs = FirebaseFirestore.instance.collection('wisata').doc(index);
    return StreamBuilder(
      stream: wisataRef.doc(index).snapshots(),
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
            child: PageView(
                physics: BouncingScrollPhysics(),
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  ListView.builder(
                    itemCount: pictures.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, images){
                      return Container(
                        margin: EdgeInsets.only(right: 28.8),
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(pictures[images], scale: 1.2),
                            )
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 19.2,
                                left: 19.2,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.8),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaY: 19.2,
                                        sigmaX: 19.2
                                    ),
                                    /*child: Container(
                                      height: 36,
                                      padding: EdgeInsets.only(left: 15, right: 14.4),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/svg/location_on.svg'),
                                          SizedBox(
                                            width: 8.52,
                                          ),
                                          Text(
                                            wisataDoc['nama'],
                                            style: GoogleFonts.lato(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 16.8
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),*/
                                  ),
                                )
                            )
                          ],
                        ),
                      );
                    }
                  )

                ],
            ),
          ),
        );
      },
    );
  }
}
