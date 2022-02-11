import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wisata_kebumen/account/account.dart';
import 'package:wisata_kebumen/homepage/newhome.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List pages = [
    NewHomepage(),
    Account(),
  ];

  int current = 0;

  void ontap(int index){
    setState(() {
      current = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarTheme(
        data: BottomNavigationBarThemeData(
          selectedItemColor: Color(0xff69bcfc),
          selectedLabelStyle: TextStyle(
            fontSize: 0,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 0,
          ),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          currentIndex: current,
          onTap: ontap,
          backgroundColor: Color(0xfff5f4f4),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: "Account"
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: pages[current],
      ),
    );
  }
}
