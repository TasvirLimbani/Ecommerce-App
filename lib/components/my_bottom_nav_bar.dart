import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
        bottom: kDefaultPadding,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: SvgPicture.asset("assets/icons/flower.svg"),
            onPressed: () {
              setState(() {
                currentIndex=0;
              });
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/heart.svg"),
            onPressed: () {
               setState(() {
                currentIndex=1;
              });
            },
          ),
          IconButton(
            icon: SvgPicture.asset("assets/icons/user.svg"),
            onPressed: () {
               setState(() {
                currentIndex=2;
              });
            },
          ),
        ],
      ),
    );
  }
}
