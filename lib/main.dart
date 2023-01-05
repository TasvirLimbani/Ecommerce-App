import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:plant_app/User/screens/check.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Drawer.dart';
import 'package:plant_app/constants.dart';

Future<void> main() async {
  Stripe.publishableKey =
      "pk_test_51LpVSsBEG5rHnLePIlCdjG8Nb0FYrJPA7MRjwkiDzndjWEQFGph9lGzMtSgSkbb3aHcNb19U6WyAym2UbjhPtYAR00Deri6pwp";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: 'Plant App',

      theme: ThemeData(
        // scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        primarySwatch: primarySwatch,
        // textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        // visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Check(),
    );
  }
}
