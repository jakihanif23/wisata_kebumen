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

class Wisata{
  String nama;
  String foto;
  List<String> pictures = <String>[];

  Wisata(this.nama, this.foto, List<String> pictures);

  Wisata.fromSnapshot(DocumentSnapshot snapshot)
  : nama = snapshot['nama'], foto = snapshot['foto'], pictures = List.from(snapshot['pictures']);

}
