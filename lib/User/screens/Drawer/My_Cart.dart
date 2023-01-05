import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/cart_model.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/User/screens/Drawer/My_Cards.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Payment_class.dart';
import 'package:plant_app/constant/buy_now_button.dart';
import 'package:plant_app/constant/cart_card.dart';
import 'package:plant_app/utils/Text_utils.dart';

List<CartModel> allPrice = [];
List<int> t = [];
List<int> tot = [];
bool buyNow = false;
// List? qut ;
int total = 0;

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  final TextUtils _textUtils = TextUtils();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allPrice.clear();
    t.clear();
    tot.clear();
    total = 0;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<UserData>(
      stream: DatabaseService().User,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userdata = snapshot.data;
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Icon(Icons.arrow_back_ios),SizedBox(width: 10,),
                    Row(
                      children: [
                        Container(
                          height: 59,
                          width: 59,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage('${userdata!.profileUrl}'),
                                fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _textUtils.bold14(
                            "Good Morning!\n${userdata.name}", Colors.black),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     _textUtils.bold14("Total : ", Colors.black),
                    //     _textUtils.bold14line("\$${subtotal()}", primaryColor),
                    //   ],
                    // ),
                  ],
                ),
              ),
              StreamBuilder<List<CartModel>>(
                stream: DatabaseService().cartlist,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cartData = snapshot.data;
                    allPrice.addAll(snapshot.data!);
                    List qut =
                        List<int>.generate(cartData!.length, (index) => 1);

                    return Column(
                      children: [
                        Container(
                          height: size.height * 0.711,
                          child: ListView.builder(
                              itemCount: cartData.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 40),
                                          height: 100,
                                          width: 100,
                                          // color: primaryColor,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade200,
                                              boxShadow: const [
                                                BoxShadow(
                                                    blurRadius: 16,
                                                    spreadRadius: 1,
                                                    color: Colors.grey)
                                              ]),
                                          child: Container(
                                            height: size.height * .1,
                                            width: size.height * .1,
                                            // width: 90,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Image.network(
                                                  cartData[index].image.first,
                                                  frameBuilder: (context,
                                                      child,
                                                      frame,
                                                      wasSynchronouslyLoaded) {
                                                return child;
                                              }, loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: primaryColor
                                                          .withOpacity(0.3),
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
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            tileColor:
                                                primaryColor.withOpacity(0.3),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                _textUtils.bold18(
                                                    cartData[index].name,
                                                    Colors.black),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 20, left: 40),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          _textUtils.bold14(
                                                              "Price : ",
                                                              Colors.black),
                                                          _textUtils.bold14(
                                                              "\$${cartData[index].price}",
                                                              Colors.red),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          _textUtils.bold14(
                                                              "Qut : ",
                                                              Colors.black),
                                                          _textUtils.bold14(
                                                              "${cartData[index].quantity}",
                                                              Colors.red),
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
                                              onTap: () async {
                                                // allPrice.clear();
                                                await FirebaseQuery
                                                    .firebaseQuery
                                                    .updateCart(
                                                        cartData[index].uid, {
                                                  "quantity":
                                                      cartData[index].quantity +
                                                          1,
                                                  "price": cartData[index]
                                                          .price +
                                                      cartData[index].s_price,
                                                });
                                                setState(() {
                                                  qut[index]++;
                                                  total +=
                                                      cartData[index].price;
                                                  if (qut[index].toInt() > 1)
                                                    tot.add(
                                                        cartData[index].price);
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
                                                        blurRadius: 5,
                                                        spreadRadius: 1,
                                                        color: Colors.grey)
                                                  ],
                                                ),
                                                child: const Center(
                                                    child: const Icon(
                                                  Icons.add,
                                                  size: 20,
                                                )),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (qut[index] > 0) {
                                                  setState(() {});
                                                  // allPrice.clear();
                                                  qut[index]--;
                                                  cartData[index].quantity > 1
                                                      ? FirebaseQuery
                                                          .firebaseQuery
                                                          .updateCart(
                                                              cartData[index]
                                                                  .uid,
                                                              {
                                                              "quantity": cartData[
                                                                          index]
                                                                      .quantity -
                                                                  1,
                                                              "price": cartData[
                                                                          index]
                                                                      .price -
                                                                  cartData[
                                                                          index]
                                                                      .s_price,
                                                            })
                                                      : null;
                                                  total -=
                                                      cartData[index].price;
                                                  tot.remove(
                                                      cartData[index].price);
                                                }
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 5,
                                                        spreadRadius: 1,
                                                        color: Colors.grey)
                                                  ],
                                                ),
                                                child: const Center(
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

                                //  CartCard(
                                //   calss: cartData[index],
                                // );
                              }),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    offset: Offset(0, -1),
                                    color: Colors.grey),
                              ]),
                          width: size.width,
                          child: Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BuyNowButton(
                                onTap: () async {
                                  setState(() {
                                    // isLoading = true;
                                    buyNow = true;
                                  });

                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      appBar: AppBar(
                                        title: _textUtils.bold18(
                                            "My Cards & Wallet", Colors.white),
                                        centerTitle: true,
                                      ),
                                      body: MyCards(
                                        productimage: cartData.first.image,
                                        productname: cartData.first.name,
                                        quantity:
                                            cartData.first.quantity.toDouble(),
                                        name: cartData.first.marchant_name,
                                        productId: cartData.first.id,
                                        image: cartData.first.marchant_image,
                                        ammount:
                                            cartData.first.price.toDouble(),
                                        showBottombar: true,
                                      ),
                                    ),
                                  ));
                                  setState(() {
                                    // isLoading = true;
                                    buyNow = false;
                                  });
                                },
                                buyNow: buyNow,
                              ),
                              Row(
                                children: [
                                  _textUtils.bold14("Total : ", Colors.black),
                                  _textUtils.bold14line(
                                      "\$${cartData.first.price}",
                                      primaryColor),
                                ],
                              ),
                              // GestureDetector(
                              //   onTap: () async {
                              //     await FirebaseQuery.firebaseQuery.addFavorite({
                              //       'uid': plantdata.uid,
                              //     });
                              //   },
                              //   child: Icon(Icons.favorite),
                              // ),
                              // Row(
                              //   mainAxisSize: MainAxisSize.min,
                              //   children: [
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           quality > 1 ? quality-- : null;
                              //         });
                              //       },
                              //       child: Container(
                              //         height: 40,
                              //         width: 40,
                              //         decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: primaryColor),
                              //         child: Center(
                              //           child: Icon(
                              //             Icons.remove,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     _textUtils.bold16("$quality", Colors.black),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     GestureDetector(
                              //       onTap: () {
                              //         setState(() {
                              //           quality >= 1 ? quality++ : null;
                              //         });
                              //       },
                              //       child: Container(
                              //         height: 40,
                              //         width: 40,
                              //         decoration: BoxDecoration(
                              //             shape: BoxShape.circle,
                              //             color: primaryColor),
                              //         child: Center(
                              //           child: Icon(
                              //             Icons.add,
                              //             color: Colors.white,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  subtotal() {
    total = 0;
    t = [];

    allPrice.forEach((element) {
      t.add(element.price);
    });
    allPrice.clear();
    t.forEach((element) {
      total += element;
    });

    log("xndncdjncjddbcj" + total.toString());
    return total;
  }

  gettotal() {
    double t = 0;
    tot.forEach((element) {
      t += element;
    });
    return t;
  }
}
