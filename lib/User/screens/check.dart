import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plant_app/Marchant/HomeScreen.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/User/screens/home/home_screen.dart';
import 'package:plant_app/User/screens/login/login.dart';

class Check extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

   Check({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    if (_auth.currentUser != null) {
      return StreamBuilder<UserData>(
        stream: DatabaseService().User,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            final userdata = snapshot.data;
            return Scaffold(
              body: userdata!.type=="User"?HomeScreen():MarchantHome(),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }
      );
    } else {
      return const LoginPage();
    }
  }
}
