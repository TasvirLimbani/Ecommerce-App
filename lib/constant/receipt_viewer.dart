import 'package:flutter/material.dart';
import 'package:plant_app/User/models/payment.dart';

class receiptViewer extends StatelessWidget {
  final PaymentModel paymentModel;
  const receiptViewer({Key? key, required this.paymentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: size.height * 0.9,
        width: size.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(paymentModel.receipt_url), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
