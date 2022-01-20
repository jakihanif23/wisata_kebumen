import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:wisata_kebumen/hotel/selectedhotel.dart';
import 'package:wisata_kebumen/login_and_register/login.dart';
import 'package:wisata_kebumen/restoran/selectedrestoran.dart';
import 'package:wisata_kebumen/wisata/selectedwisata.dart';
import 'package:wisata_kebumen/wisatamodel.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({Key? key}) : super(key: key);

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  final _pageController = PageController(viewportFraction: 0.877);
  final _stream = ReadData();

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      }
    });
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  height: 50,
                  margin: EdgeInsets.only(top: 20, left: 28.8, right: 28.8),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0x080a0928)),
                        child: SvgPicture.asset('assets/svg/newlists.svg',
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                //Text Wisata Kebumen
                Padding(
                  padding: EdgeInsets.only(left: 28.8, top: 20),
                  child: Text(
                    'Wisata Kebumen',
                    style: GoogleFonts.openSans(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                //custom tab bar
                Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 14.4, top: 28.8),
                  child: TabBar(
                    labelPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    indicatorPadding: EdgeInsets.only(left: 14.4, right: 14.4),
                    isScrollable: true,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black38,
                    labelStyle: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    unselectedLabelStyle: GoogleFonts.lato(
                        fontSize: 14, fontWeight: FontWeight.w700),
                    indicator: MaterialIndicator(
                        bottomRightRadius: 5,
                        bottomLeftRadius: 5,
                        topLeftRadius: 5,
                        topRightRadius: 5,
                        horizontalPadding: 12),
                    tabs: [
                      Tab(
                        child: Container(
                          child: Text('Wisata'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Restoran'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Rest Area'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Hotel'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Rumah Sakit'),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: Text('Lorem Ipsum'),
                        ),
                      ),
                    ],
                  ),
                ),
                //pageview
                SizedBox(
                  height: 240,
                  child: TabBarView(children: [
                    StreamBuilder(
                      stream: _stream.getStreamWisata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
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
                              children: snapshot.data!.docs.map((document) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 28.8),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(document['foto'],
                                              scale: 1.0),
                                        )),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 19.2,
                                            left: 19.2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.8),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 19.2, sigmaX: 19.2),
                                                child: Container(
                                                  height: 36,
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 14.4),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/location_on.svg'),
                                                      SizedBox(
                                                        width: 8.52,
                                                      ),
                                                      Text(
                                                        document['nama'],
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedWisata(
                                                    index: document['nama'])));
                                  },
                                );
                              }).toList()),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: _stream.getStreamRestoran(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
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
                              children: snapshot.data!.docs.map((document) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 28.8),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(document['foto'],
                                              scale: 1.0),
                                        )),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 19.2,
                                            left: 19.2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.8),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 19.2, sigmaX: 19.2),
                                                child: Container(
                                                  height: 36,
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 14.4),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/location_on.svg'),
                                                      SizedBox(
                                                        width: 8.52,
                                                      ),
                                                      Text(
                                                        document['nama'],
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedRestoran(
                                                    index: document['nama'])));
                                  },
                                );
                              }).toList()),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: _stream.getStreamWisata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
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
                              children: snapshot.data!.docs.map((document) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 28.8),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(document['foto'],
                                              scale: 1.0),
                                        )),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 19.2,
                                            left: 19.2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.8),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 19.2, sigmaX: 19.2),
                                                child: Container(
                                                  height: 36,
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 14.4),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/location_on.svg'),
                                                      SizedBox(
                                                        width: 8.52,
                                                      ),
                                                      Text(
                                                        document['nama'],
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedWisata(
                                                    index: document['nama'])));
                                  },
                                );
                              }).toList()),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: _stream.getStreamHotel(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
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
                              children: snapshot.data!.docs.map((document) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 28.8),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(document['foto'],
                                              scale: 1.0),
                                        )),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 19.2,
                                            left: 19.2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.8),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 19.2, sigmaX: 19.2),
                                                child: Container(
                                                  height: 36,
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 14.4),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/location_on.svg'),
                                                      SizedBox(
                                                        width: 8.52,
                                                      ),
                                                      Text(
                                                        document['nama'],
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedHotel(
                                                    index: document['nama'])));
                                  },
                                );
                              }).toList()),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: _stream.getStreamWisata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
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
                              children: snapshot.data!.docs.map((document) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 28.8),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(document['foto'],
                                              scale: 1.0),
                                        )),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 19.2,
                                            left: 19.2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.8),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 19.2, sigmaX: 19.2),
                                                child: Container(
                                                  height: 36,
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 14.4),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/location_on.svg'),
                                                      SizedBox(
                                                        width: 8.52,
                                                      ),
                                                      Text(
                                                        document['nama'],
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedWisata(
                                                    index: document['nama'])));
                                  },
                                );
                              }).toList()),
                        );
                      },
                    ),
                    StreamBuilder(
                      stream: _stream.getStreamWisata(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
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
                              children: snapshot.data!.docs.map((document) {
                                return InkWell(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 28.8),
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(document['foto'],
                                              scale: 1.0),
                                        )),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            bottom: 19.2,
                                            left: 19.2,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4.8),
                                              child: BackdropFilter(
                                                filter: ImageFilter.blur(
                                                    sigmaY: 19.2, sigmaX: 19.2),
                                                child: Container(
                                                  height: 36,
                                                  padding: EdgeInsets.only(
                                                      left: 15, right: 14.4),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                          'assets/svg/location_on.svg'),
                                                      SizedBox(
                                                        width: 8.52,
                                                      ),
                                                      Text(
                                                        document['nama'],
                                                        style: GoogleFonts.lato(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Colors.white,
                                                            fontSize: 16.8),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SelectedWisata(
                                                    index: document['nama'])));
                                  },
                                );
                              }).toList()),
                        );
                      },
                    ),
                  ]),
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
                        spacing: 5),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () async {
                    GoogleSignIn googleUserlogout = await GoogleSignIn();
                    await FirebaseAuth.instance.signOut();
                    googleUserlogout.signOut();
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text('Logout'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        User? user = FirebaseAuth.instance.currentUser;
                        return Text(user!.displayName.toString());
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
