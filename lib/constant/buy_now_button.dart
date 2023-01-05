import 'package:flutter/material.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class BuyNowButton extends StatelessWidget {
  void Function()? onTap;
  bool buyNow;
  double indicatorhight = 15;
  double containerweight = 150;
  double containerheight = 40;
  String title;
  double fontsize = 16;
  EdgeInsetsGeometry? padding = EdgeInsets.symmetric(vertical: 12);
  BuyNowButton(
      {Key? key,
      this.buyNow = false,
      this.indicatorhight = 15,
      this.containerweight = 150,
      this.containerheight = 40,
      this.fontsize = 16,
      this.title = "BUY NOW",
      this.onTap,
      this.padding})
      : super(key: key);
  final TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buyNow ? null : onTap,
      child: Container(
        width: containerweight,
        height: containerheight,
        padding: padding,
        // padding:,
        decoration: BoxDecoration(
          color: buyNow ? primaryColor.withOpacity(0.4) : primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: buyNow
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: indicatorhight,
                      width: indicatorhight,
                      child: CircularProgressIndicator(
                        color: Colors.white60,
                        strokeWidth: 2,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  fontsize == 16
                      ? _textUtils.bold16("$title", Colors.white)
                      : _textUtils.bold14("$title", Colors.white)
                ],
              )
            : Center(
                child: fontsize == 16
                    ? _textUtils.bold16("$title", Colors.white)
                    : _textUtils.bold14("$title", Colors.white)),
      ),
    );
  }
}
