import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage1 extends StatelessWidget {
  const HomePage1({Key? key}) : super(key: key);

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
                        color: Color(0x08D2D2D2)
                      ),
                      child: SvgPicture.asset('assets/svg/icon.svg'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
