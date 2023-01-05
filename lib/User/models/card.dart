import 'package:cloud_firestore/cloud_firestore.dart';

class BankCardModel {
  String cardNumber = "";
  String expiryDate = "";
  String cardHolderName = "";
  String cvvCode = "";
  String uid = "";

  BankCardModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    cardHolderName = data['cardHolderName'];
    expiryDate = data['expiryDate'];
    cardNumber = data['cardNumber'];
    cvvCode = data['cvvCode'];
    uid = snapshot.id;
  }
}
