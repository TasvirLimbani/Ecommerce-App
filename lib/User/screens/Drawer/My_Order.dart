import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/order_model.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key? key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return StreamBuilder<List<OrderModel>>(
        stream: DatabaseService().orderlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return OrderCard(
                  orderModel: data[index],
                );
              },
            );
          }
          if (snapshot.hasError) {
            return _textUtils.bold14(snapshot.error.toString(), Colors.black);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class OrderCard extends StatefulWidget {
  final OrderModel orderModel;
  const OrderCard({Key? key, required this.orderModel}) : super(key: key);

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  TextUtils _textUtils = TextUtils();
  DateFormat _dateFormat = DateFormat('dd-MM-yyyy');
  int _current = 0;
  int currentIndex = -1;
  int currentStep = -1;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
      height: size.height * 0.17,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // borderRadius: const BorderRadius.only(
        //     topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: primaryColor.withOpacity(0.4),
      ),
      child: Row(
        children: [
          Container(
            width: size.width * 0.4,
            height: size.height * 0.15,
            child: CarouselSlider(
              items: widget.orderModel.productimage
                  .map(
                    (e) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: size.width * 0.4,
                      height: size.height * 0.15,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                          frameBuilder:
                              (context, child, frame, wasSynchronouslyLoaded) {
                            return child;
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor.withOpacity(0.4),
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
                      widget.orderModel.productimage.length == 1 ? false : true,
                  onPageChanged: (index, _) {
                    setState(() {
                      _current = index;
                    });
                  },
                  scrollPhysics: widget.orderModel.productimage.length == 1
                      ? const NeverScrollableScrollPhysics()
                      : const BouncingScrollPhysics(),
                  // enlargeCenterPage: true,
                  viewportFraction: 1),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: _textUtils.bold18(
                          widget.orderModel.productname, Colors.black)),
                  Row(
                    children: [
                      _textUtils.bold16("Price : ", Colors.black),
                      _textUtils.bold16(
                          "\$${widget.orderModel.amount}", Colors.red),
                    ],
                  ),
                  Row(
                    children: [
                      _textUtils.bold16("Quantity : ", Colors.black),
                      _textUtils.bold16(
                          widget.orderModel.quantity.toStringAsFixed(0),
                          Colors.red),
                    ],
                  ),
                  Container(
                    height: 40,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 5),
                          child: currentIndex >= index
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.star_rate_rounded,
                                    size: 30,
                                    color: primaryColor,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      currentIndex = index;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.star_border_rounded,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
