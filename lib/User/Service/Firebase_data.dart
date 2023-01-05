import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_app/Marchant/Models/MarchantMode.dart';
import 'package:plant_app/Marchant/Models/Marchant_payment.dart';
import 'package:plant_app/Marchant/Models/orderModel.dart';
import 'package:plant_app/User/models/address_model.dart';
import 'package:plant_app/User/models/card.dart';
import 'package:plant_app/User/models/cart_model.dart';
import 'package:plant_app/User/models/order_model.dart';
import 'package:plant_app/User/models/payment.dart';
import 'package:plant_app/User/models/plant.dart';
import 'package:plant_app/User/models/user.dart';
// import 'package:plant_app/User/screens/Drawer/My_Cards.dart';

class DatabaseService {
  String userId = '';
  // final String? uid;
  // DatabaseService({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');
  final CollectionReference plantCollection =
      FirebaseFirestore.instance.collection('Plant');

  DatabaseService() {
    userId = FirebaseAuth.instance.currentUser!.uid;
  }
  // Future userData(
  //   String email,
  //   String phone,
  //   String name,
  //   String password,
  //   String status,
  //   int posts,
  //   String profile_pic,
  //   bool verified,
  //   bool is_public,
  //   bool show_active_status,
  //   bool push_notification,
  // ) async {
  //   return await userCollection.doc(userId).set({
  //     'Email': email,
  //     'Password': password,
  //     'posts': posts,
  //     'name': name,
  //     'phone': phone,
  //     'profile_pic': profile_pic,
  //     'status': status,
  //     'show_active_status': show_active_status,
  //     'push_notification': push_notification,
  //     'verified': verified,
  //     'is_public': is_public,
  //   });
  // }
  // Future cardData(
  //   String cardNumber,
  //   String expiryDate,
  //   String cardHolderName,
  //   String cvvCode,
  // ) async {
  //   return await userCollection.doc(userId).collection('card').doc().set({
  //     'CvvCode': cvvCode,
  //     'CardHolderName': cardHolderName,
  //     'ExpiryDate': expiryDate,
  //     'CardNumber': cardNumber,
  //   });
  // }

  Stream<UserData> get User {
    return userCollection.doc(userId).snapshots().map((e) {
      UserData user = UserData.fromSnapShort(e);
      return user;
    });
  }
  Stream<UserData>  getUser ({required String uid}) {
    return userCollection.doc(uid).snapshots().map((e) {
      UserData user = UserData.fromSnapShort(e);
      return user;
    });
  }
  Stream<MarchantData> get Marchant {
    return userCollection.doc(userId).snapshots().map((e) {
      MarchantData marchant = MarchantData.fromSnapShort(e);
      return marchant;
    });
  }

  Stream<PlantModel> SinglePlant({required String uid}) {
    return plantCollection.doc(uid).snapshots().map((e) {
      PlantModel plantdata = PlantModel.fromSnapShort(e);
      return plantdata;
    });
  }

  Stream<List<PlantModel>> get plant {
    return plantCollection.snapshots().map((e) {
      List<PlantModel> modesl = e.docs.map((et) {
        return PlantModel.fromSnapShort(et);
      }).toList();
      return modesl;
    });
  }

  Stream<List<BankCardModel>> get bankCard {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('card')
        .snapshots()
        .map(cards);
  }

  List<BankCardModel> cards(QuerySnapshot data) {
    return data.docs.map((e) => BankCardModel.fromSnapShort(e)).toList();
  }

  Stream<List<PaymentModel>> get payment {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('payment')
        .orderBy("date")
        .snapshots()
        .map(payments);
  }

  List<PaymentModel> payments(QuerySnapshot data) {
    return data.docs.map((e) => PaymentModel.fromSnapShort(e)).toList();
  }

  Stream<List<CartModel>> get cartlist {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .orderBy('date')
        .snapshots()
        .map(carts);
  }

  List<CartModel> carts(QuerySnapshot data) {
    return data.docs.map((e) => CartModel.fromSnapShort(e)).toList();
  }
  Stream<List<OrderModel>> get orderlist {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('order')
        .orderBy('date')
        .snapshots()
        .map(orders);
  }

  List<OrderModel> orders(QuerySnapshot data) {
    return data.docs.map((e) => OrderModel.fromSnapShort(e)).toList();
  }
  Stream<List<MarchantOrderModel>> get marchantorderlist {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('order')
        .orderBy('date')
        .snapshots()
        .map(marchantorders);
  }

  List<MarchantOrderModel> marchantorders(QuerySnapshot data) {
    return data.docs.map((e) => MarchantOrderModel.fromSnapShort(e)).toList();
  }
  Stream<List<AddressModel>> get addresslist {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('address')
        .snapshots()
        .map(address);
  }

  List<AddressModel> address(QuerySnapshot data) {
    return data.docs.map((e) => AddressModel.fromSnapShort(e)).toList();
  }

  Stream<List<MarchantPaymentModel>> get marchantpaymentlist {
    return userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('payment')
        .orderBy("date")
        .snapshots()
        .map(marchantpayments);
  }

  List<MarchantPaymentModel> marchantpayments(QuerySnapshot data) {
    return data.docs.map((e) => MarchantPaymentModel.fromSnapShort(e)).toList();
  }

}
