import 'package:cloud_firestore/cloud_firestore.dart';

class AddressModel {
  String address1 = "";
  String address2 = "";
  String city = "";
  String state = "";
  String zipcode = "";
  String uid = "";

  AddressModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    address1 = data['address1'];
    address2 = data['address2'];
    city = data['city'];
    state = data['state'];
    zipcode = data['zipcode'];
    uid = snapshot.id;
  }
}
