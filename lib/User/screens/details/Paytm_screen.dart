// // ignore_for_file: prefer_interpolation_to_compose_strings

// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:paytm/paytm.dart';

// class Paytm_Payment extends StatefulWidget {
//   const Paytm_Payment({Key? key}) : super(key: key);

//   @override
//   State<Paytm_Payment> createState() => _Paytm_PaymentState();
// }

// class _Paytm_PaymentState extends State<Paytm_Payment> {
//   late String payment_response;
//   String mid = "LIVE_MID_HERE";
//   String PAYTM_MERCHANT_KEY = "LIVE_KEY_HERE";
//   String website = "DEFAULT";
//   bool testing = false;
//   double amount = 1;
//   bool loading = true;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ElevatedButton(
//           onPressed: () {
//             generateTxnToken(3);
//           },
//           child: Text("Pay Now")),
//     );
//   }

//   void generateTxnToken(int mode) async {
//     Dio dio = Dio(BaseOptions(
//       headers: {'Content-type': "application/json"},
//     ));
//     String orderId = DateTime.now().millisecondsSinceEpoch.toString();

//     String callBackUrl = (testing
//             ? 'https://securegw-stage.paytm.in'
//             : 'https://securegw.paytm.in') +
//         '/theia/paytmCallback?ORDER_ID=' +
//         orderId;

//     //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
//     //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server
//     var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';

//     var body = json.encode({
//       "mid": mid,
//       "key_secret": PAYTM_MERCHANT_KEY,
//       "website": website,
//       "orderId": orderId,
//       "amount": amount.toString(),
//       "callbackUrl": callBackUrl,
//       "custId": "122",
//       "mode": mode.toString(),
//       "testing": testing ? 0 : 1
//     });

//     try {
//       final response = await dio.post(
//         url,
//         data: body,
//       );
//       print("Response is");
//       print(response.data);
//       String txnToken = response.data[""];
//       setState(() {
//         payment_response = txnToken;
//       });
//       var paytmResponse = Paytm.payWithPaytm(
//           mId: mid,
//           orderId: orderId,
//           txnToken: txnToken,
//           txnAmount: amount.toString(),
//           callBackUrl: callBackUrl,
//           staging: testing,
//           appInvokeEnabled: false);

//       paytmResponse.then((value) {
//         print(value);
//         setState(() {
//           loading = false;   
//           print("Value is ");
//           print(value);
//           if (value['error']) {
//             payment_response = value['errorMessage'];
//           } else {
//             if (value['response'] != null) {
//               payment_response = value['response']['STATUS'];
//             }
//           }
//           payment_response += "\n" + value.toString();
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }
