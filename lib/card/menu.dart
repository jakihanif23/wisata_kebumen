import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final String itemText;
  final IconData itemIcon;
  final int selected;
  final int position;

  MenuItem(this.selected, this.position, {required this.itemIcon,required this.itemText});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected == position ? Color(0xff3bb2ff) : Color(0xff69BCFC),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Icon(
              itemIcon,
              color: Colors.white,
            )
          ),
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                itemText,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
        ],
      ),
    );
  }
}