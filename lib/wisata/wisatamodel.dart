import 'package:cloud_firestore/cloud_firestore.dart';

class ReadData{
  final CollectionReference collectionWisata = FirebaseFirestore.instance.collection('wisata');
  final CollectionReference collectionRestoran = FirebaseFirestore.instance.collection('restoran');

  Stream<QuerySnapshot> getStreamWisata(){
    return collectionWisata.snapshots();
  }
  Stream<QuerySnapshot> getStreamRestoran(){
    return collectionRestoran.snapshots();
  }
}