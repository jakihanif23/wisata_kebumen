import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WisataLists extends StatefulWidget {
  const WisataLists({Key? key}) : super(key: key);

  @override
  _WisataListsState createState() => _WisataListsState();
}

class _WisataListsState extends State<WisataLists> {

  final _stream = FirebaseFirestore.instance.collection('wisata').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _stream,
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
                      onTap: ()=>print(Text(document['nama'])),
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
