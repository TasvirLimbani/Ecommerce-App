import 'package:flutter/material.dart';
import 'package:plant_app/Marchant/Drawer/Account_Setting/Account_Setting.dart';
import 'package:plant_app/Marchant/Drawer/Account_Setting/Help_center.dart';
import 'package:plant_app/Marchant/Drawer/Address.dart';
import 'package:plant_app/Marchant/Drawer/All_Orders.dart';
import 'package:plant_app/Marchant/Drawer/My_card_wallet.dart';
import 'package:plant_app/Marchant/Drawer/Notification.dart';
import 'package:plant_app/User/screens/Drawer/Account_Setting/Account_Setting.dart';
import 'package:plant_app/User/screens/Drawer/Help_Center.dart';
import 'package:plant_app/User/screens/Drawer/My_Addresse.dart';
import 'package:plant_app/User/screens/Drawer/My_Cards.dart';
import 'package:plant_app/User/screens/Drawer/My_Cart.dart';
import 'package:plant_app/User/screens/Drawer/My_Order.dart';
import 'package:plant_app/User/screens/Drawer/My_Rewards.dart';
import 'package:plant_app/User/screens/Drawer/Notification.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MarchantNavigatorScreen extends StatelessWidget {
  final String name;
  const MarchantNavigatorScreen({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextUtils _textUtils = TextUtils();
    return Scaffold(
      appBar: AppBar(
        title: _textUtils.bold18(name, Colors.white),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          if (name == "Account Setting") MarchantAccountSetting(),
          if (name == "Notifications") MarchntNotificationScreen(),
          // if(name=="Your Cart") MyCart(),
          if (name == "All Orders") MarchantOrders(),
          if (name == "My Cards & Wallet") MarchantCards(),
          // if(name=="My Rewards")MyRewards(),
          if (name == "My Addresses") MarchantAddresse(),
          if (name == "Help Center") MarchantHelpCenter(),
        ],
      ),
    );
  }
}
