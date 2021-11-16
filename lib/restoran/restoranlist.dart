import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wisata_kebumen/wisata/wisatamodel.dart';

import 'detailrestoran.dart';

class RestoranLists extends StatefulWidget {
  const RestoranLists({Key? key}) : super(key: key);

  @override
  _RestoranListsState createState() => _RestoranListsState();
}

class _RestoranListsState extends State<RestoranLists> {

  final _stream = ReadData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _stream.getStreamRestoran(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document){
              return Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width/1.1,
                  height: MediaQuery.of(context).size.height/9,
                  child: Card(
                    child: ListTile(
                      title: Text(document['nama']),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailRestoran(index: document['nama'])));
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
