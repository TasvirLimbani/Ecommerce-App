import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:plant_app/Marchant/Models/Marchant_payment.dart';
import 'package:plant_app/Marchant/Models/orderModel.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/pdf/label.dart';
import 'package:plant_app/pdf/label_download.dart';
import 'package:plant_app/utils/Text_utils.dart';

class DashBordScreen extends StatefulWidget {
  const DashBordScreen({Key? key}) : super(key: key);

  @override
  State<DashBordScreen> createState() => _DashBordScreenState();
}

class _DashBordScreenState extends State<DashBordScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextUtils _textUtils = TextUtils();
  final DateTime _dateTime = DateTime.now();
  int todayOrder = 0;
  double percent = 0.0;
  List todayOrders = [];
  List totalPayments = [];
  final DateFormat _dateFormat = DateFormat.yMd();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MarchantOrderModel>>(
        stream: DatabaseService().marchantorderlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orderdata = snapshot.data;
            todayOrders.clear();
            for (int i = 0; i < orderdata!.length; i++) {
              orderdata[i].date!.day == _dateTime.day
                  ? todayOrders.add(orderdata[i])
                  : null;
              percent = orderdata[i].date!.day == _dateTime.day
                  ? (todayOrders.length * 100) / 100 / 100
                  : 0;
            }
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                5, 10, 5, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: CircularPercentIndicator(
                                      percent: percent,
                                      radius: 42.5,
                                      lineWidth: 18,
                                      animation: true,
                                      progressColor: const Color(0xFF27B53E),
                                      backgroundColor: const Color(0xFF97F98B),
                                      center: _textUtils.bold16(
                                          "${percent.toString().split(".").last}%",
                                          Colors.black)),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _textUtils.bold25(
                                          "${todayOrders.length}", Colors.black)
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade300,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _textUtils.bold25("10", Colors.white)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            indent: 8,
                            endIndent: 8,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 10, 10, 0),
                            child: Container(
                              width: double.infinity,
                              height: 280,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color: Color(0x33000000),
                                    offset: Offset(0, 2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              15, 8, 0, 0),
                                      child: _textUtils.bold20(
                                          "Today\'s Orders", Colors.black)),
                                  const Divider(
                                    indent: 10,
                                    endIndent: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 0, 0),
                                      child: orderdata.isEmpty
                                          ? Center(
                                              child: Image.network(
                                                  'https://cdni.iconscout.com/illustration/premium/thumb/man-receiving-canceled-orders-back-4438793-3718471.png'),
                                            )
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: orderdata.length,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.vertical,
                                              itemBuilder: (context, index) {
                                                todayOrder =
                                                    orderdata[index].date ==
                                                            _dateTime.day
                                                        ? orderdata.length
                                                        : 0;
                                                return orderdata[index]
                                                            .date!
                                                            .day ==
                                                        _dateTime.day
                                                    ? ListTile(
                                                       
                                                        onTap: () {
                                                          showModalBottomSheet<
                                                              void>(
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            shape:
                                                                const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                            ),
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return OrderLabel(
                                                                order:
                                                                    orderdata[
                                                                        index],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        leading: Container(
                                                          height: 40,
                                                          width: 40,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                Image.network(
                                                              orderdata[index]
                                                                  .productimage
                                                                  .first
                                                                  .toString(),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        title: _textUtils.bold18(
                                                            orderdata[index]
                                                                .productname,
                                                            Colors.black),
                                                        subtitle: _textUtils.bold14(
                                                            "quantity : ${orderdata[index].quantity.toString().split(".").first}",
                                                            Colors
                                                                .grey.shade700),
                                                        trailing: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: const Color(
                                                              0xFF303030),
                                                          size: 20,
                                                        ),
                                                        tileColor: const Color(
                                                            0xFFF5F5F5),
                                                        dense: false,
                                                      )
                                                    : Container();
                                              },
                                            ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(0, 5, 15, 10),
                                          child: _textUtils.bold14("Show All",
                                              Colors.grey.shade700)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          StreamBuilder<List<MarchantPaymentModel>>(
                              stream: DatabaseService().marchantpaymentlist,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final paymentdata = snapshot.data;
                                  totalPayments.clear();
                                  for (int i = 0;
                                      i < paymentdata!.length;
                                      i++) {
                                    paymentdata[i].date.day <= _dateTime.day - 7
                                        ? totalPayments.add(paymentdata[i])
                                        : null;
                                  }
                                  return Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            10, 10, 10, 10),
                                    child: Container(
                                      width: double.infinity,
                                      height: 280,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x33000000),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(15, 8, 0, 0),
                                              child: _textUtils.bold20(
                                                  "Payments", Colors.black)),
                                          const Divider(
                                            indent: 10,
                                            endIndent: 10,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(0, 5, 0, 0),
                                              child: totalPayments.isEmpty
                                                  ? Center(
                                                      child: _textUtils.bold14(
                                                          "No Payment",
                                                          Colors.black),
                                                    )
                                                  : ListView.builder(
                                                      itemCount:
                                                          paymentdata.length,
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                          title: _textUtils.bold16(
                                                              "Payment \$${paymentdata[index].amount.toStringAsFixed(0)} Only",
                                                              Colors.black),
                                                          subtitle:
                                                              _textUtils.bold14(
                                                                  "${_dateFormat.format(paymentdata[index].date)}",
                                                                  Colors.grey
                                                                      .shade700),
                                                          trailing: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .attach_money,
                                                                color: Color(
                                                                    0xFF303030),
                                                                size: 20,
                                                              ),
                                                              _textUtils.bold14(
                                                                  "+ ${paymentdata[index].amount.toStringAsFixed(0)}",
                                                                  Colors.green)
                                                            ],
                                                          ),
                                                          tileColor:
                                                              const Color(
                                                                  0xFFF5F5F5),
                                                          dense: false,
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                          0, 5, 15, 10),
                                                  child: _textUtils.bold14(
                                                      "Show All ",
                                                      Colors.grey.shade700)),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: _textUtils.bold16(snapshot.error.toString(), Colors.black),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
