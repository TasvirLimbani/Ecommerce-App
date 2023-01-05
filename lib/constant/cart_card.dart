import 'package:flutter/material.dart';
import 'package:plant_app/User/models/cart_model.dart';
import 'package:plant_app/User/screens/Drawer/My_Cart.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class CartCard extends StatefulWidget {
  final CartModel calss;
  final int index;
  const CartCard({Key? key, required this.calss,required this.index}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  TextUtils _textUtils = TextUtils();
  int qut = 1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 40),
              height: 100,
              width: 100,
              // color: primaryColor,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 16, spreadRadius: 1, color: Colors.grey)
                  ]),
              child: Container(
                height: size.height * .1,
                width: size.height * .1,
                // width: 90,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.network(widget.calss.image.first, frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return child;
                  }, loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor.withOpacity(0.3),
                        ),
                      );
                    }
                  }),
                ),
              )),
          Positioned(
            right: 15,
            top: 0,
            bottom: 0,
            child: Container(
              width: size.width * 0.8,
              height: 100,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: ListTile(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
                tileColor: primaryColor.withOpacity(0.3),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _textUtils.bold18(widget.calss.name, Colors.black),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, left: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              _textUtils.bold14("Price : ", Colors.black),
                              _textUtils.bold14(
                                  "\$${widget.calss.price}", Colors.red),
                            ],
                          ),
                          Row(
                            children: [
                              _textUtils.bold14("Qut : ", Colors.black),
                              _textUtils.bold14("$qut", Colors.red),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -15,
            right: 25,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      qut++;
                      total += widget.calss.price;
                      tot.add(widget.calss.price);
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5, spreadRadius: 1, color: Colors.grey)
                      ],
                    ),
                    child: Center(
                        child: Icon(
                      Icons.add,
                      size: 20,
                    )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      qut--;
                      total -= widget.calss.price;
                      tot.remove(widget.calss.price);
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5, spreadRadius: 1, color: Colors.grey)
                      ],
                    ),
                    child: Center(
                        child: Icon(
                      Icons.remove,
                      size: 20,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
