import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  double amount = 0;
  DateTime? date;
  DateTime? delivery_expected_date;
  String image = "";
  List productimage = [];
  String name = "";
  String productname = "";
  String productId = "";
  String receipt_url = "";
  double quantity = 0;
  String uid = "";

  OrderModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    Timestamp orderdate = data['date'];
    Timestamp deliverydate = data['delivery_expected_date'];
    amount = data['amount'];
    image = data['image'];
    productimage =
        (data['productimage'] as List).map((e) => e.toString()).toList();
    name = data['name'];
    productname = data['productname'];
    productId = data['productId'];
    receipt_url = data['receipt_url'];
    quantity = data['quantity'];
    date = orderdate.toDate();
    delivery_expected_date = deliverydate.toDate();
    uid = snapshot.id;
  }
}
