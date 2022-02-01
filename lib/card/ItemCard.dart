import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCard extends StatelessWidget {
  final String nama_user;
  final num rating;
  final String komentar;

  ItemCard(this.nama_user, this.rating, this.komentar);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(nama_user,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 16)),
              ),
              Text(
                "Rating $rating",
                style: GoogleFonts.poppins(),
              ),
              Text(
                komentar,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}