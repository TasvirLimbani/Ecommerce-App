import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/User/screens/Drawer/Account_Setting/Account_Setting.dart';
import 'package:plant_app/User/screens/home/components/body.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Drawer.dart';
import 'package:plant_app/utils/Text_utils.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  TextUtils _textUtils = TextUtils();

  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: buildAppBar(),
      drawer: MyDrawer(),
      body: currentIndex == 0
          ? Body()
          : currentIndex == 1
              ? Container()
              : AccountSetting(),
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
                icon: SvgPicture.asset("assets/icons/flower_outline.svg",
                    height: 22),
                activeIcon: SvgPicture.asset(
                  "assets/icons/flower.svg",
                  height: 22,
                  color: primaryColor,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: SvgPicture.asset("assets/icons/heart_outline.svg",
                    height: 22),
                activeIcon: SvgPicture.asset("assets/icons/heart.svg",
                    height: 22, color: primaryColor),
                label: ""),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset("assets/icons/user.svg",
                    height: 22, color: primaryColor),
                icon: SvgPicture.asset("assets/icons/user_outline.svg",
                    height: 22),
                label: ""),
          ]),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        color: primaryColor,
      ),
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {
          // FirebaseHelper.Auth.logout();
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
          _key.currentState!.openDrawer();
        },
      ),
      centerTitle: true,
      title: currentIndex == 0
          ? _textUtils.bold25("Products", Colors.grey.shade100)
          : currentIndex == 1
              ? _textUtils.bold25("Favorite Items", Colors.grey.shade100)
              : _textUtils.bold25("Account Setting", Colors.grey.shade100),
    );
  }
}
