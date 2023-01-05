import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '';
class FirebaseQuery {
  FirebaseQuery._();
  static final FirebaseQuery firebaseQuery = FirebaseQuery._();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
String userId = FirebaseAuth.instance.currentUser!.uid; 

  //User
  Future<void> insertuser(String userId, Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).set(data);
  }
    Future<void> updateUser( Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).update(data);
  }
    Future<void> deleteUser() async {
    firebaseFirestore.collection('User').doc(userId).delete();
  }

  // //Add-Favorite
  //   Future<void> addFavorite(String uid,Map<String , dynamic> data) async {
  //   firebaseFirestore.collection('User').doc(userId).collection('Favorite').doc(uid).set(data);
  // }

  // //Remove-Favorite
  //   Future<void> RemoveFavorite(String uid) async {
  //   firebaseFirestore.collection('User').doc(userId).collection('Favorite').doc(uid).delete();
  // }

  //Plant -- Marchant
  Future<void> uploadPlant(Map<String, dynamic> data) async {
    firebaseFirestore.collection('Plant').add(data);
  }

  // Card
   Future<void> insertCard( Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).collection("card").doc().set(data);
  }


  // Payments
   Future<void> addPayment( Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).collection("payment").doc().set(data);
  }

  // Payments
   Future<void> addMarchantPayment(String uid, Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(uid).collection("payment").doc().set(data);
  }

  // cart
   Future<void> addtoCart( Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).collection("cart").doc().set(data);
  }
   Future<void> updateCart(String uid, Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).collection("cart").doc(uid).update(data);
  }

   // order
   Future<void> insertOrder( Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).collection("order").doc().set(data);
  }
   // address
   Future<void> addAddress( Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(userId).collection("address").doc().set(data);
  }
   // order -- Marchant
   Future<void> addMarchantOrder(String uid, Map<String, dynamic> data) async {
    firebaseFirestore.collection('User').doc(uid).collection("order").doc().set(data);
  }

    //Plant -- Marchant
  Future<void> sendFeedback(String uid,Map<String, dynamic> data) async {
    firebaseFirestore.collection('Feedback').add(data);
  }
}