import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  String productId = "";
  String name = "";
  String image = "";
  DateTime date = DateTime.now();
  double amount = 0;
  String receipt_url = "";
  String uid = "";

  PaymentModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    Timestamp time = data['date'];
    productId = data['productId'];
    name = data['name'];
    image = data['image'];
    receipt_url = data['receipt_url'];
    date = time.toDate();
    amount = data['amount'];
    uid = snapshot.id;
  }
}
