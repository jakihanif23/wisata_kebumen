import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardWisata extends StatelessWidget {

  final String foto_wisata;
  final String nama_wisata;
  CardWisata(this.foto_wisata, this.nama_wisata);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
          image: CachedNetworkImageProvider(
            foto_wisata
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
                          nama_wisata,
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
    );
  }
}
