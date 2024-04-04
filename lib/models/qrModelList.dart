import 'package:cloud_firestore/cloud_firestore.dart';

class QrScannedModel{
  String id;
  String name;
  String image;
  String phone;
  String place;
  Timestamp milliTme;


  QrScannedModel(this.id,this.name,this.image,this.phone,this.place,this.milliTme);

}
