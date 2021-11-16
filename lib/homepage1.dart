import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wisata_kebumen/wisata/wisatamodel.dart';

class HomePage1 extends StatefulWidget {
  const HomePage1({Key? key}) : super(key: key);

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {

  final _pageController = PageController(viewportFraction: 0.877);
  final _stream = ReadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                height: 57.6,
                margin: EdgeInsets.only(top: 28.8, left: 28.8, right: 28.8),
                child: Row(
                  children: [
                    Container(
                      height: 57.6,
                      width: 57.6,
                      padding: EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0x080a0928)
                      ),
                      child: SvgPicture.asset('assets/svg/arrow-left.jpg', color: Colors.black45),
                    ),
                  ],
                ),
              ),

              //pageview
              StreamBuilder(
                stream: _stream.getStreamWisata(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container(
                    height: 218.4,
                    margin: EdgeInsets.only(top: 18),
                    child: PageView(
                        physics: BouncingScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        children: snapshot.data!.docs.map((document){
                          return Container(
                            margin: EdgeInsets.only(right: 28.8),
                            width: 333.6,
                            height: 218.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(document['foto'], scale: 1.0),
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
                                        child: Container(
                                          height: 36,
                                          padding: EdgeInsets.only(left: 16.72, right: 14.4),
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              SvgPicture.asset('assets/svg/location_on.svg'),
                                              SizedBox(
                                                width: 9.52,
                                              ),
                                              Text(
                                                document['nama'],
                                                style: GoogleFonts.lato(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                  fontSize: 16.8
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),
                          );
                        }).toList()
                    ),
                  );
                },
              ),
              //dots indicator
              Padding(
                padding: EdgeInsets.only(left: 28.8, top: 28.8),
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 9,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color(0xFF8a8a8a),
                    dotColor: Color(0xFFababab),
                    dotHeight: 4.8,
                    dotWidth: 6,
                    spacing: 5
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
