import 'package:cloud_firestore/cloud_firestore.dart';

class MarchantOrderModel {
  double amount = 0;
  DateTime? date;
  DateTime? delivery_expected_date;
  String image = "";
  String userId = "";
  List productimage = [];
  String name = "";
  String productname = "";
  String productId = "";
  String receipt_url = "";
  String user_address1 = "";
  String user_address2 = "";
  String user_city = "";
  String user_state = "";
  String user_zipcode = "";
  double quantity = 0;
  String uid = "";

  MarchantOrderModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    Timestamp orderdate = data['date'];
    Timestamp deliverydate = data['delivery_expected_date'];
    amount = data['amount'];
    image = data['image'];
    productimage =
        (data['productimage'] as List).map((e) => e.toString()).toList();
    name = data['name'];
    productname = data['productname'];
    userId = data['userId'];
    productId = data['productId'];
    receipt_url = data['receipt_url'];
    quantity = data['quantity'];
    user_address1 = data['user_address1'];
    user_address2 = data['user_address2'];
    user_city = data['user_city'];
    user_state = data['user_state'];
    user_zipcode = data['user_zipcode'];
    date = orderdate.toDate();
    delivery_expected_date = deliverydate.toDate();
    uid = snapshot.id;
  }
}
