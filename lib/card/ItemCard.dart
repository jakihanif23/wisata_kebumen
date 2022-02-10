import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ItemCard extends StatelessWidget {
  final String nama_user;
  final num rating;
  final String komentar;

  ItemCard(this.nama_user, this.rating, this.komentar);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(3,3)
          )
        ]
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.black26,
              child: Icon(Icons.person, color: Colors.white, size: 60,),
            ),
          ),
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Text(nama_user,
                    style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500,
                      color: Colors.black
                    )
                ),
              ),
              RatingBarIndicator(
                  itemCount: 5,
                  itemSize: 20,
                  rating: double.parse(rating.toString()),
                  itemBuilder: (context, _) {
                    return Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  }
              ),
              Text(
                komentar,
              ),
            ],
          ),
        ],
      ),
    );
  }
}