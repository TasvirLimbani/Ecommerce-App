import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  List image = [];
  String name = "";
  int quantity = 0;
  int price = 0;
  int s_price = 0;
  String id = "";
  String marchant_name = "";
  String marchant_image = "";
  DateTime? date;
  String uid = "";

  CartModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    Timestamp time = data["date"];
    image = (data['image'] as List).map((e) => e.toString()).toList();
    name = data['name'];
    quantity = data['quantity'];
    marchant_name = data['marchant_name'];
    marchant_image = data['marchant_image'];
    price = data['price'];
    s_price = data['s_price'];
    id = data['Id'];
    date = time.toDate();
    uid = snapshot.id;
  }
}
