import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/User/models/card.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class CardView extends StatelessWidget {
  BankCardModel bankCardModel;
  CardView({Key? key, required this.bankCardModel}) : super(key: key);
  final TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      height: 199,
      width: 344,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: primaryColor.withOpacity(0.5)),
      child: Stack(
        children: <Widget>[
          Positioned(
            child: SvgPicture.asset(
              'assets/icons/ellipse_top_pink.svg',
              color: primaryColor.withOpacity(0.4),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/icons/ellipse_bottom_pink.svg',
              color: primaryColor.withOpacity(0.4),
            ),
          ),
          Positioned(
            left: 29,
            top: 48,
            child: _textUtils.bold14("CARD NUMBER", Colors.black),
          ),
          Positioned(
            left: 29,
            top: 65,
            child: _textUtils.bold14(
                bankCardModel.cardNumber.replaceRange(0, 14, "**** **** ****"),
                Colors.black),
          ),
          Positioned(
            right: 21,
            top: 35,
            child: Image.asset(
              'assets/images/mastercard_logo.png',
              width: 27,
              height: 27,
            ),
          ),
          Positioned(
            left: 29,
            bottom: 45,
            child: _textUtils.bold14("CARD HOLDERNAME", Colors.black),
          ),
          Positioned(
            left: 29,
            bottom: 21,
            child:
                _textUtils.bold14(bankCardModel.cardHolderName, Colors.black),
          ),
          Positioned(
            left: 202,
            bottom: 45,
            child: _textUtils.bold14("EXPIRY DATE", Colors.black),
          ),
          Positioned(
            left: 202,
            bottom: 21,
            child: _textUtils.bold14(bankCardModel.expiryDate, Colors.black),
          )
        ],
      ),
    );
  }
}
