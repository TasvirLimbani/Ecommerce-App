// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/User/Address/address.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/plant.dart';
import 'package:plant_app/User/screens/Drawer/My_Cards.dart';
import 'package:plant_app/User/screens/details/Paytm_screen.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/Payment_class.dart';
import 'package:plant_app/constant/buy_now_button.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:http/http.dart' as http;

class DetailsScreen extends StatefulWidget {
  String uid;
  DetailsScreen({Key? key, required this.uid}) : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextUtils _textUtils = TextUtils();
  CarouselController carouselController = CarouselController();
  int _current = 0;
  int quality = 1;
  int? countControllerValue;
  bool buyNow = false;
  bool addcart = false;
  double discount = 0;
  String Cardnumber = "4242424242424242";
  String Cardexpiredate = "12/22";
  String Cardcvv = "458";
  String CardHoldername = "Tasvir Teast Card";
  double amount = 89;
  bool isLoading = false;

  void sum(int price, int mrp) {
    discount = (price * 100) / mrp - 100;
    log(discount.toString());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder<PlantModel>(
          stream: DatabaseService().SinglePlant(uid: widget.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final plantdata = snapshot.data;
              sum(int.parse(plantdata!.plant_Price),
                  int.parse(plantdata.plant_Mrp));
              log(
                "sdfsdfdsffdsfsf" + plantdata.marchant_id,
              );
              return Stack(
                children: [
                  Container(
                    height: size.height,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    CarouselSlider(
                                      items: plantdata.plant_Image
                                          .map(
                                            (e) => Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              width: double.infinity,
                                              height: 250,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  width: 5,
                                                ),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  e,
                                                  fit: BoxFit.cover,
                                                  frameBuilder: (context,
                                                      child,
                                                      frame,
                                                      wasSynchronouslyLoaded) {
                                                    return child;
                                                  },
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          color: primaryColor
                                                              .withOpacity(0.4),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      options: CarouselOptions(
                                          autoPlay:
                                              plantdata.plant_Image.length == 1
                                                  ? false
                                                  : true,
                                          onPageChanged: (index, _) {
                                            setState(() {
                                              _current = index;
                                            });
                                          },
                                          scrollPhysics: plantdata
                                                      .plant_Image.length ==
                                                  1
                                              ? NeverScrollableScrollPhysics()
                                              : BouncingScrollPhysics(),
                                          // enlargeCenterPage: true,
                                          viewportFraction: 1),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Container(
                                    height: 15,
                                    width: plantdata.plant_Image.length * 21,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                      ),
                                    ),
                                    child: Center(
                                      child: ListView.builder(
                                        itemCount: plantdata.plant_Image.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            // padding: EdgeInsets.symmetric(horizontal: 10),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 7),
                                            height: _current == index ? 8 : 8,
                                            width: _current == index ? 8 : 8,
                                            decoration: BoxDecoration(
                                              color: _current == index
                                                  ? primaryColor
                                                  : primaryColor
                                                      .withOpacity(0.4),
                                              shape: BoxShape.circle,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        _textUtils.bold35(
                                            "${plantdata.plant_Name}",
                                            Colors.grey.shade800),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              bottomLeft: Radius.circular(15),
                                            ),
                                            color:
                                                primaryColor.withOpacity(0.4),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            child: Center(
                                              child: _textUtils.bold16(
                                                  discount
                                                          .toStringAsFixed(0)
                                                          .split("-")
                                                          .last +
                                                      "% Off",
                                                  Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        _textUtils.bold13tho(
                                            '\$${plantdata.plant_Mrp}',
                                            Colors.grey.shade600),
                                        _textUtils.bold30(
                                          "\$${plantdata.plant_Price}",
                                          primaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _textUtils.bold25("Product Details :",
                                        Colors.grey.shade600),
                                    _textUtils.bold16(
                                        "See All", Colors.blue.shade300),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                plantdata.plant_Small
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.height,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          _textUtils.bold16(
                                              "Plant height - 6 to 12 inch",
                                              Colors.black),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                plantdata.plant_Water
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.water_drop,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          _textUtils.bold16(
                                              "Watering Schedule - once a day.",
                                              Colors.black),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.home,
                                      color: primaryColor.withOpacity(0.6),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    plantdata.plant_Air
                                        ? _textUtils.bold16(
                                            "Indoor/Outdoor Usage : Indoor",
                                            Colors.black)
                                        : _textUtils.bold16(
                                            "Indoor/Outdoor Usage : Outdoor",
                                            Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                plantdata.plant_Sun
                                    ? Row(
                                        children: [
                                          Icon(
                                            Icons.sunny,
                                            color: Colors.amber,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          _textUtils.bold16(
                                              "Sun Schedule - Every 2 days.",
                                              Colors.black),
                                        ],
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.shopify_rounded,
                                      color: Colors.blueGrey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    plantdata.net_quantity.isNotEmpty
                                        ? _textUtils.bold16(
                                            "Net Quantity	 : ${plantdata.net_quantity}",
                                            Colors.black)
                                        : _textUtils.bold16(
                                            "Net Quantity	 : 0", Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.line_weight,
                                      color: Colors.purple,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    plantdata.plant_weight.isNotEmpty
                                        ? _textUtils.bold16(
                                            "Item Weight : ${plantdata.plant_weight}",
                                            Colors.black)
                                        : _textUtils.bold16(
                                            "Item Weight : 0g", Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color: Colors.brown,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    plantdata.plant_weight.isNotEmpty
                                        ? _textUtils.bold16(
                                            "Manufacturer : ${plantdata.manufacturer}",
                                            Colors.black)
                                        : _textUtils.bold16(
                                            "Manufacturer : All", Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.public,
                                      color: Colors.green.shade800,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    plantdata.plant_weight.isNotEmpty
                                        ? _textUtils.bold16(
                                            "County : ${plantdata.country}",
                                            Colors.black)
                                        : _textUtils.bold16(
                                            "County : India", Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                          text: plantdata.plant_Details,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 75,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
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
                              showModalBottomSheet<void>(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return OrderAddress(plantdata: plantdata,);
                                },
                              );
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => Scaffold(
                              //     appBar: AppBar(
                              //       title: _textUtils.bold18(
                              //           "My Cards & Wallet", Colors.white),
                              //       centerTitle: true,
                              //     ),
                              //     body: MyCards(
                              //       uid: plantdata.marchant_id,
                              //       productimage: plantdata.plant_Image,
                              //       productname: plantdata.plant_Name,
                              //       name: plantdata.marchant_name,
                              //       productId: plantdata.uid,
                              //       image: plantdata.marchant_image,
                              //       quantity: 1,
                              //       ammount:
                              //           double.parse(plantdata.plant_Price),
                              //       showBottombar: true,
                              //     ),
                              //   ),
                              // ));
                              setState(() {
                                // isLoading = true;
                                buyNow = false;
                              });
                            },
                            buyNow: buyNow,
                          ),
                          BuyNowButton(
                            title: "Add Cart",
                            onTap: () async {
                              setState(() {
                                // isLoading = true;
                                addcart = true;
                              });
                              Timer(Duration(seconds: 3), () async {
                                await FirebaseQuery.firebaseQuery.addtoCart({
                                  "image": plantdata.plant_Image,
                                  "name": plantdata.plant_Name,
                                  "quantity": int.parse(plantdata.net_quantity),
                                  "price": int.parse(plantdata.plant_Price),
                                  "s_price": int.parse(plantdata.plant_Price),
                                  "date": DateTime.now(),
                                  "Id": plantdata.uid,
                                  "marchant_name": plantdata.marchant_name,
                                  "marchant_image": plantdata.marchant_image,
                                });
                                setState(() {
                                  // isLoading = true;
                                  addcart = false;
                                });
                              });
                            },
                            buyNow: addcart,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 4),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}




/* Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
              child: SizedBox(
                height: size.height * 0.75,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding * 3),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: kDefaultPadding),
                                icon: SvgPicture.asset(
                                    "assets/icons/back_arrow.svg"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            widget.plantModel.plant_Sun
                                ? const Spacer()
                                : Container(),
                            widget.plantModel.plant_Sun
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.03),
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 2),
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 15),
                                          blurRadius: 22,
                                          color:
                                              kPrimaryColor.withOpacity(0.22),
                                        ),
                                        const BoxShadow(
                                          offset: Offset(-15, -15),
                                          blurRadius: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/sun.svg'),
                                  )
                                : Container(),
                            widget.plantModel.plant_Small
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.03),
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 2),
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 15),
                                          blurRadius: 22,
                                          color:
                                              kPrimaryColor.withOpacity(0.22),
                                        ),
                                        const BoxShadow(
                                          offset: Offset(-15, -15),
                                          blurRadius: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/icon_2.svg'),
                                  )
                                : Container(),
                            widget.plantModel.plant_Water
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.03),
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 2),
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 15),
                                          blurRadius: 22,
                                          color:
                                              kPrimaryColor.withOpacity(0.22),
                                        ),
                                        const BoxShadow(
                                          offset: Offset(-15, -15),
                                          blurRadius: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/icon_3.svg'),
                                  )
                                : Container(),
                            widget.plantModel.plant_Air
                                ? Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: size.height * 0.03),
                                    padding: const EdgeInsets.all(
                                        kDefaultPadding / 2),
                                    height: 62,
                                    width: 62,
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 15),
                                          blurRadius: 22,
                                          color:
                                              kPrimaryColor.withOpacity(0.22),
                                        ),
                                        const BoxShadow(
                                          offset: const Offset(-15, -15),
                                          blurRadius: 20,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        'assets/icons/icon_4.svg'),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: size.height * 0.8,
                      width: size.width * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(63),
                          bottomLeft: Radius.circular(63),
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 10),
                            blurRadius: 60,
                            color: kPrimaryColor.withOpacity(0.29),
                          ),
                        ],
                        // image:  DecorationImage(
                        //   alignment: Alignment.centerLeft,
                        //   fit: BoxFit.cover,
                        //   image:  NetworkImage("${widget.plantModel.plant_Image}"),
                        // ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(63),
                          bottomLeft: Radius.circular(63),
                        ),
                        child: InteractiveViewer(
                          // boundaryMargin: EdgeInsets.all(80),
                          panEnabled: false,
                          scaleEnabled: true,
                          minScale: 1.0,
                          maxScale: 2.2,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      widget.plantModel.plant_Image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _textUtils.bold35("${widget.plantModel.plant_Name}",Colors.grey.shade800),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _textUtils.bold20throw("${widget.plantModel.plant_Mrp}", Colors.red.shade300),
                      SizedBox(width: 10,),
                      _textUtils.bold30("${widget.plantModel.plant_Price}", primaryColor),
                    ],
                  ),
                  // RichText(
                  //   text: TextSpan(
                  //     children: [
                  //       TextSpan(
                  //         text: "${widget.plantModel.plant_Name}",
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .headline4!
                  //             .copyWith(
                  //                 color: kTextColor,
                  //                 fontWeight: FontWeight.bold),
                  //       ),
                  //       const TextSpan(
                  //         text: 'Russia',
                  //         style: const TextStyle(
                  //           fontSize: 20,
                  //           color: kPrimaryColor,
                  //           fontWeight: FontWeight.w300,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // const Spacer(),
                  // Text(
                  //   "\$440",
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .headline5!
                  //       .copyWith(color: kPrimaryColor),
                  // )
               
                ],
              ),
            ),
            // TitleAndPrice(title: "Angelica", country: "Russia", price: 440),
            const SizedBox(height: kDefaultPadding),
            Row(
              children: <Widget>[
                SizedBox(
                  width: size.width / 2,
                  height: 84,
                  child: FlatButton(
                    shape: const RoundedRectangleBorder(
                      borderRadius:  BorderRadius.only(
                        topRight:  Radius.circular(20),
                      ),
                    ),
                    color: kPrimaryColor,
                    onPressed: () {},
                    child: const Text(
                      "Buy Now",
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {},
                    child: const Text("Description"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ); */
