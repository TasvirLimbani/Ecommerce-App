import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:gallery_saver/gallery_saver.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/models/StripeModel.dart';
import 'package:plant_app/User/screens/Success/Success_screen.dart';
import 'package:plant_app/User/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/constant/Confirmation_screen.dart';
import 'package:uuid/uuid.dart';

Future<void> makePayment(
    {required String Cardcvv,
    required String Cardnumber,
    required int month,
    required int year,
    required double amount,
    required String name,
    required String uid,
    required double quantity,
    required String image,
    required List productimage,
    required String productname,
    required String productId,
    required String address1,
    required String address2,
    required String city,
    required String state,
    required String zipcode,
    required BuildContext context}) async {
  try {
    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
        cvc: Cardcvv,
        expirationMonth: 11,
        expirationYear: 26,
        number: Cardnumber));

    final paymentMethod =
        await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());

    final paymentIntentResult = await createPaymentIntent(
        productimage: productimage,
        productname: productname,
        quantity: quantity,
        image: image,
        uid: uid,
        name: name,
        productId: productId,
        currency: 'USD',
        amount: amount,
        context: context,
        paymentMethodId: paymentMethod.id,
        useStripeSdk: true,
        address1: address1,
        address2: address2,
        city: city,
        state: state,
        zipcode: zipcode);
    final paymentIntent = await Stripe.instance
        .retrievePaymentIntent(paymentIntentResult['client_secret']);
    //  .handleCardAction(paymentIntentResult['client_secret']);

    await confirmIntent(paymentIntent.id);
  } catch (e, s) {}
}

String receipt_image = "";
StripeData stripeData = StripeData();
List<StripeData> allData = [];
DateTime _dateTime = DateTime.now();
Random _random = Random();
Future<Map<String, dynamic>> createPaymentIntent({
  required bool useStripeSdk,
  required String paymentMethodId,
  required String currency,
  required String name,
  required double quantity,
  required String image,
  required String uid,
  required List productimage,
  required String productname,
  required String productId,
  required String address1,
  required String address2,
  required String city,
  required String state,
  required String zipcode,
  required double amount,
  required BuildContext context,
  List<Map<String, dynamic>>? items,
}) async {
  Map<String, dynamic> body = {
    'amount':
        calculateAmount(amount == null ? "00" : amount.toStringAsFixed(2)),
    'currency': currency,
    'payment_method': paymentMethodId,
    'payment_method_types[]': 'card',
    'confirm': 'true',
  };

  Dio _dio = Dio(BaseOptions(headers: {
    'Authorization':
        'Bearer sk_test_51LpVSsBEG5rHnLePYhkRI9Tw6wyvjxIDExxuFFeYg7jXsQ8XtjUrsS3rAqXcv18Ogis2nCA8rc16QXXDiDvheRHT00WN4JkYmT',
    'Content-Type': 'application/x-www-form-urlencoded'
  }));
  final response = await _dio.post(
    'https://api.stripe.com/v1/payment_intents',
    data: body,
  );
  stripeData = StripeData.fromJson(response.data);
  // log(stripeData.toString());
  // log(stripeData.charges!.data!.first.receiptUrl.toString());
  // allData =
  //     List<StripeData>.from(response.data.map((x) => StripeData.fromJson(x)));
  // log(allData.toString());

  if (response.data["status"] == "succeeded") {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => SuccessScreen(),
        ),
        (route) => false);
    print("asdasdasdsada   ===> " + uid);
    FirebaseQuery.firebaseQuery.addPayment({
      "image": image,
      "amount": amount,
      "date": DateTime.now(),
      "name": name,
      "productId": productId,
      // "receipt_url": receipt_image,
      "receipt_url": "${stripeData.charges!.data!.first.receiptUrl}",
    });

    FirebaseQuery.firebaseQuery.insertOrder({
      "image": image,
      "productimage": productimage,
      "amount": amount,
      "date": DateTime.now(),
      "name": name,
      "productname": productname,
      "productId": productId,
      // "receipt_url": receipt_image,
      "receipt_url": "${stripeData.charges!.data!.first.receiptUrl}",
      'quantity': quantity,
      'delivery_expected_date': DateTime(
          _dateTime.year, _dateTime.month, _dateTime.day + _random.nextInt(9)),
    });
    FirebaseQuery.firebaseQuery.addMarchantOrder(uid, {
      "image": image,
      "productimage": productimage,
      "amount": amount,
      "date": DateTime.now(),
      "name": name,
      "productname": productname,
      "productId": productId,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      "receipt_url": "${stripeData.charges!.data!.first.receiptUrl}",
      'quantity': quantity,
      'user_address1': address1,
      'user_address2': address2,
      'user_city': city,
      'user_state': state,
      'user_zipcode': zipcode,
      'delivery_expected_date': DateTime(
          _dateTime.year, _dateTime.month, _dateTime.day + _random.nextInt(9)),
    });
    FirebaseQuery.firebaseQuery.addMarchantPayment(uid, {
      "image": image,
      "amount": amount,
      "date": DateTime.now(),
      "name": name,
      "productId": productId,
      // "receipt_url": receipt_image,
      "receipt_url": "${stripeData.charges!.data!.first.receiptUrl}",
    });
  }

  print('Create Intent reponse ===> ${response.data}');
  print(body);
  return jsonDecode(response.data);
}

Future<Map<String, dynamic>> GetIntentID({
  required String paymentIntentId,
}) async {
  final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
  final response = await http.post(
    url,
    headers: {
      'Authorization':
          'Bearer sk_test_51LpVSsBEG5rHnLePYhkRI9Tw6wyvjxIDExxuFFeYg7jXsQ8XtjUrsS3rAqXcv18Ogis2nCA8rc16QXXDiDvheRHT00WN4JkYmT',
      'Content-Type': 'application/x-www-form-urlencoded'
    },
    body: json.encode({'paymentIntentId': paymentIntentId}),
  );
  print("sdfsdfsdfdgdfgfd");
  return json.decode(response.body);
}

Future<void> confirmIntent(String paymentIntentId) async {
  final result = await GetIntentID(paymentIntentId: paymentIntentId);
  if (result['error'] != null) {
  } else {}
}

calculateAmount(String amount) {
  // String aa = ((double.parse(amount)).toString() + 00.toString()).toString();
  final a = amount.toString().replaceAll(".", "");
  return a.toString();
}
