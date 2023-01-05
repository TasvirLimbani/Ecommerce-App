import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/Marchant/Add_Plant.dart';
import 'package:plant_app/Marchant/Drawer/Account_Setting/Account_Setting.dart';
import 'package:plant_app/Marchant/dashbord.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Drawer.dart';
import 'package:plant_app/constant/Marchant_Drawer.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MarchantHome extends StatefulWidget {
  const MarchantHome({Key? key}) : super(key: key);

  @override
  State<MarchantHome> createState() => _MarchantHomeState();
}

class _MarchantHomeState extends State<MarchantHome> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextUtils _textUtils = TextUtils();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: currentIndex == 1 ? null : buildAppBar(),
      drawer: MarchantDrawer(),
      body: currentIndex == 0
          ? DashBordScreen()
          : currentIndex == 1
              ? AddPlant()
              : MarchantAccountSetting(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        currentIndex: currentIndex,
        selectedItemColor: primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.spa_outlined,
                size: 25,
              ),
              activeIcon: Icon(
                Icons.spa,
                size: 25,
                color: primaryColor,
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: 25),
              activeIcon: Icon(Icons.add_box, size: 25, color: primaryColor),
              label: ""),
          BottomNavigationBarItem(
              activeIcon:
                  Icon(Icons.account_circle, size: 25, color: primaryColor),
              icon: Icon(Icons.account_circle_outlined, size: 25),
              label: ""),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        color: primaryColor,
      ),
      centerTitle: true,
      title: currentIndex == 0
          ? _textUtils.bold20("DashBord", Colors.white)
          : null,
      actions: currentIndex == 0
          ? [
              Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(Icons.refresh, color: Colors.white))
            ]
          : null,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          // FirebaseHelper.Auth.logout();
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
          _key.currentState!.openDrawer();
        },
      ),
    );
  }
}
