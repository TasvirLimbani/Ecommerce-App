// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/address_model.dart';
import 'package:plant_app/User/models/card.dart';
import 'package:plant_app/User/models/payment.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/constant/Card_view.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Payment_class.dart';
import 'package:plant_app/constant/add_card.dart';
import 'package:plant_app/constant/buy_now_button.dart';
import 'package:plant_app/constant/receipt_viewer.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MyCards extends StatefulWidget {
  final double ammount;
  final double quantity;
  final String image;
  final List? productimage;
  final String productname;
  final AddressModel? address;
  final String uid;
  final String name;
  final String productId;
  final bool showBottombar;
  const MyCards(
      {Key? key,
      this.ammount = 0,
      this.quantity = 0,
      this.showBottombar = false,
      this.image = '',
      this.uid = '',
      this.productimage,
      this.address,
      this.productname = '',
      this.name = '',
      this.productId = ''})
      : super(key: key);

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  int current = 0;
  TextUtils _textUtils = TextUtils();

  // Handle Indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  String cardNumber = "";
  String cardcvv = "";
  int exMonth = 0;
  int exYear = 0;
  int currentIndex = -1;
  String cardHolderName = "";
  bool paynow = false;
  DateFormat dateFormat = DateFormat.yMMMMd();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<UserData>(
        stream: DatabaseService().User,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data;
            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    children: <Widget>[
                      // Custom AppBar
                      Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 16),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            // Icon(Icons.arrow_back_ios),SizedBox(width: 10,),
                            Container(
                              height: 59,
                              width: 59,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image:
                                        NetworkImage('${userdata!.profileUrl}'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _textUtils.bold14("Good Morning!\n${userdata.name}",
                                Colors.black),
                          ],
                        ),
                      ),

                      // Card Section
                      const SizedBox(
                        height: 25,
                      ),

                      StreamBuilder<List<BankCardModel>>(
                          stream: DatabaseService().bankCard,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final cardData = snapshot.data;

                              return Container(
                                height: 199,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.only(left: 16, right: 6),
                                  itemCount: cardData!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentIndex = index;
                                          cardNumber =
                                              cardData[index].cardNumber;
                                          cardcvv = cardData[index].cvvCode;
                                          exMonth = int.parse(cardData[index]
                                              .expiryDate
                                              .split("/")
                                              .first);
                                          exYear = int.parse(cardData[index]
                                              .expiryDate
                                              .split("/")
                                              .last);
                                          cardHolderName =
                                              cardData[index].cardHolderName;
                                        });
                                      },
                                      child: Container(
                                        // padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width:
                                                  currentIndex == index ? 4 : 0,
                                              color: currentIndex == index
                                                  ? Colors.black
                                                  : Colors.transparent),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        child: CardView(
                                            bankCardModel: cardData[index]),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Container();
                          }),

                      // Operation Section
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 13, top: 29, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _textUtils.bold16("Operation", Colors.black),
                            Row(
                              children: map<Widget>(
                                datas,
                                (index, selected) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    height: 7,
                                    width: 7,
                                    margin: const EdgeInsets.only(right: 6),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: current == index
                                            ? kBlueColor
                                            : kTwentyBlueColor),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        height: 123,
                        child: ListView.builder(
                          itemCount: datas.length,
                          padding: const EdgeInsets.only(left: 16),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                                index == 0
                                    ? showModalBottomSheet(
                                        isScrollControlled: true,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AddCard();
                                        })
                                    : null;
                              },
                              child: OperationCard(
                                  operation: datas[index].name,
                                  selectedIcon: datas[index].selectedIcon,
                                  unselectedIcon: datas[index].unselectedIcon,
                                  isSelected: current == index,
                                  context: context),
                            );
                          },
                        ),
                      ),

                      // Transaction Section
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, bottom: 13, top: 29, right: 10),
                        child: _textUtils.bold16(
                            "Transaction Histories", Colors.black),
                      ),
                      StreamBuilder<List<PaymentModel>>(
                          stream: DatabaseService().payment,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final paymentData = snapshot.data;
                              return ListView.builder(
                                itemCount: paymentData!.length,
                                reverse: true,
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  receiptViewer(
                                                      paymentModel:
                                                          paymentData[index])));
                                    },
                                    child: Container(
                                      height: 76,
                                      margin: const EdgeInsets.only(bottom: 13),
                                      padding: const EdgeInsets.only(
                                          left: 24,
                                          top: 12,
                                          bottom: 12,
                                          right: 22),
                                      decoration: BoxDecoration(
                                        color: kWhiteColor,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: kTenBlackColor,
                                            blurRadius: 10,
                                            spreadRadius: 5,
                                            offset: Offset(8.0, 8.0),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Container(
                                                height: 57,
                                                width: 57,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          paymentData[index]
                                                              .image),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 13,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _textUtils.bold16(
                                                      paymentData[index].name,
                                                      Colors.black),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  _textUtils.bold12(
                                                      dateFormat
                                                          .format(
                                                              paymentData[index]
                                                                  .date)
                                                          .toString(),
                                                      Colors.black),
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: <Widget>[
                                              _textUtils.bold14(
                                                  "- ${paymentData[index].amount}0",
                                                  Colors.black),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }

                            return Container();
                          }),
                      widget.showBottombar
                          ? SizedBox(
                              height: size.height * 0.085,
                            )
                          : Container(),
                    ],
                  ),
                ),
                widget.showBottombar
                    ? Positioned(
                        bottom: 0,
                        child: Container(
                          height: size.height * 0.085,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            height: size.height * 0.085,
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              color: primaryColor.withOpacity(0.5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BuyNowButton(
                                  title: "PAY NOW",
                                  buyNow: paynow,
                                  onTap: paynow
                                      ? null
                                      : currentIndex == -1
                                          ? () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: _textUtils.bold16(
                                                    "Please Select Card",
                                                    Colors.white),
                                                backgroundColor: Colors.red,
                                              ));
                                            }
                                          : () async {
                                              // paynow
                                              //     ?
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    StatefulBuilder(builder:
                                                        (context, setState) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              28),
                                                    ),
                                                    insetPadding:
                                                        EdgeInsets.zero,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          height: size.height *
                                                              0.28,
                                                          width:
                                                              size.width * 0.9,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          28),
                                                              color:
                                                                  Colors.white),
                                                          child: Container(
                                                            // margin:
                                                            //     EdgeInsets.symmetric(
                                                            //         horizontal: 5,
                                                            //         vertical: 5),
                                                            height:
                                                                size.height *
                                                                    0.28,
                                                            width: size.width *
                                                                0.9,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            28),
                                                                color: primaryColor
                                                                    .withOpacity(
                                                                        0.5)),
                                                            child: Stack(
                                                              children: <
                                                                  Widget>[
                                                                Positioned(
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/icons/ellipse_top_pink.svg',
                                                                    color: primaryColor
                                                                        .withOpacity(
                                                                            0.4),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  bottom: 0,
                                                                  right: 0,
                                                                  child:
                                                                      SvgPicture
                                                                          .asset(
                                                                    'assets/icons/ellipse_bottom_pink.svg',
                                                                    color: primaryColor
                                                                        .withOpacity(
                                                                            0.4),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 29,
                                                                  top: 48,
                                                                  child: _textUtils.bold14(
                                                                      "CARD NUMBER",
                                                                      Colors
                                                                          .black),
                                                                ),
                                                                Positioned(
                                                                  left: 29,
                                                                  top: 65,
                                                                  child: _textUtils.bold14(
                                                                      cardNumber
                                                                          .replaceRange(
                                                                              0,
                                                                              14,
                                                                              "**** **** ****"),
                                                                      Colors
                                                                          .black),
                                                                ),
                                                                Positioned(
                                                                  right: 21,
                                                                  top: 35,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/mastercard_logo.png',
                                                                    width: 27,
                                                                    height: 27,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 80,
                                                                  right: 15,
                                                                  child:
                                                                      Container(
                                                                    width: 100,
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                8),
                                                                        color: Colors
                                                                            .white),
                                                                    child:
                                                                        TextFormField(
                                                                      autofocus:
                                                                          true,
                                                                      validator:
                                                                          (val) {
                                                                        if (val!
                                                                            .isEmpty) {
                                                                          return "Enter CVV";
                                                                        }
                                                                      },
                                                                      inputFormatters: [
                                                                        new LengthLimitingTextInputFormatter(
                                                                            3),
                                                                      ],
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      obscureText:
                                                                          true,
                                                                      controller:
                                                                          _cvvController,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.only(left: 10),
                                                                        hintText:
                                                                            "CVV",
                                                                        border:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 29,
                                                                  bottom: 45,
                                                                  child: _textUtils.bold14(
                                                                      "CARD HOLDERNAME",
                                                                      Colors
                                                                          .black),
                                                                ),
                                                                Positioned(
                                                                  left: 29,
                                                                  bottom: 21,
                                                                  child: _textUtils.bold14(
                                                                      cardHolderName,
                                                                      Colors
                                                                          .black),
                                                                ),
                                                                Positioned(
                                                                  left: 202,
                                                                  bottom: 45,
                                                                  child: _textUtils.bold14(
                                                                      "EXPIRY DATE",
                                                                      Colors
                                                                          .black),
                                                                ),
                                                                Positioned(
                                                                  left: 202,
                                                                  bottom: 21,
                                                                  child: _textUtils.bold14(
                                                                      "$exMonth/$exYear",
                                                                      Colors
                                                                          .black),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: BuyNowButton(
                                                            title: "PAY NOW",
                                                            buyNow: paynow,
                                                            onTap: () async {
                                                              setState(() {
                                                                paynow = true;
                                                              });

                                                              _cvvController
                                                                          .text ==
                                                                      cardcvv
                                                                  ? ({
                                                                      await makePayment(
                                                                        address1: widget.address!.address1,
                                                                        address2: widget.address!.address2,
                                                                        city: widget.address!.city,
                                                                        state: widget.address!.state,
                                                                        zipcode: widget.address!.zipcode,
                                                                          uid: widget
                                                                              .uid,
                                                                          productimage: widget
                                                                              .productimage!,
                                                                          productname: widget
                                                                              .productname,
                                                                          quantity: widget
                                                                              .quantity,
                                                                          Cardcvv:
                                                                              cardcvv,
                                                                          Cardnumber:
                                                                              cardNumber,
                                                                          month:
                                                                              exMonth,
                                                                          year:
                                                                              exYear,
                                                                          amount: widget
                                                                              .ammount,
                                                                          name: widget
                                                                              .name,
                                                                          image: widget
                                                                              .image,
                                                                          productId: widget
                                                                              .productId,
                                                                          context:
                                                                              context),
                                                                      setState(
                                                                        () {
                                                                          paynow =
                                                                              false;

                                                                          _cvvController
                                                                              .clear();
                                                                        },
                                                                      ),
                                                                    })
                                                                  : ({
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                              SnackBar(
                                                                        content: _textUtils.bold14(
                                                                            "Your CVV is Wrong....",
                                                                            Colors.white),
                                                                        backgroundColor:
                                                                            Colors.red,
                                                                      )),
                                                                      setState(
                                                                          () {
                                                                        paynow =
                                                                            false;
                                                                      }),
                                                                    });
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ); //     : null;
                                            },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      children: [
                                        _textUtils.bold14("Total Cost ",
                                            Colors.grey.shade900),
                                        _textUtils.bold16("\$${widget.ammount}",
                                            Colors.black),
                                      ],
                                    ),
                                    _textUtils.bold12(
                                        "Including tax", Colors.grey.shade700),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class OperationCard extends StatefulWidget {
  final String? operation;
  final String? selectedIcon;
  final String? unselectedIcon;
  final bool? isSelected;
  BuildContext? context;

  OperationCard(
      {this.operation,
      this.selectedIcon,
      this.unselectedIcon,
      this.isSelected,
      this.context});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16, bottom: 5, top: 5),
      width: 123,
      height: 123,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              // spreadRadius: 5,
              // offset: const Offset(8.0, 8.0),
            )
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected! ? kBlueColor : kWhiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SvgPicture.asset(
            widget.isSelected! ? widget.selectedIcon! : widget.unselectedIcon!,
            color: widget.isSelected! ? Colors.white : primaryColor,
            width: 35,
            height: 35,
          ),
          const SizedBox(
            height: 9,
          ),
          _textUtils.bold13(widget.operation!, Colors.black),
        ],
      ),
    );
  }
}

final kBlueColor = primaryColor.withOpacity(0.4);
const kTwentyBlueColor = Color(0x201E1E99);
const kPinkColor = primaryColor;
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF3A3A3A);
const kTenBlackColor = Color(0x10000000);
const kBackgroundColor = Color(0xFFFAFAFA);
const kGreyColor = Color(0xff8A959E);

class TransactionModel {
  String name;
  String photo;
  String date;
  String amount;

  TransactionModel(this.name, this.photo, this.date, this.amount);
}

class OperationModel {
  String name;
  String selectedIcon;
  String unselectedIcon;

  OperationModel(this.name, this.selectedIcon, this.unselectedIcon);
}

List<OperationModel> datas = operationsData
    .map((item) => OperationModel(item['name'].toString(),
        item['selectedIcon'].toString(), item['unselectedIcon'].toString()))
    .toList();

var operationsData = [
  {
    "name": "Add Card",
    "selectedIcon": "assets/icons/add.svg",
    "unselectedIcon": "assets/icons/add.svg"
  },
  {
    "name": "Remove Cards",
    "selectedIcon": "assets/icons/delete.svg",
    "unselectedIcon": "assets/icons/delete.svg"
  },
  {
    "name": "Net Banking",
    "selectedIcon": "assets/icons/bank.svg",
    "unselectedIcon": "assets/icons/bank.svg"
  },
];

class CardModel {
  String user;
  String cardNumber;
  String cardExpired;
  String cardType;
  int cardBackground;
  String cardElementTop;
  String cardElementBottom;

  CardModel(this.user, this.cardNumber, this.cardExpired, this.cardType,
      this.cardBackground, this.cardElementTop, this.cardElementBottom);
}
