// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';
import 'dart:math';

// import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plant_app/Marchant/Models/MarchantMode.dart';
import 'package:plant_app/Marchant/Models/orderModel.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/pdf/label_download.dart';
import 'package:plant_app/utils/Text_utils.dart';
// import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class OrderLabel extends StatefulWidget {
  final MarchantOrderModel order;
  const OrderLabel({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderLabel> createState() => _OrderLabelState();
}

class _OrderLabelState extends State<OrderLabel> {
  // final dm = Barcode.dataMatrix();
  // String? filename;
  // Barcode? bc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // final svg = bc!.toSvg(widget.order.uid, width: 200, height: 80);
    // filename ??= bc!.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    // File('$filename.svg').writeAsStringSync(svg);
  }

  final DateFormat _dateFormat = DateFormat.Md();
  final TextUtils _textUtils = TextUtils();
  bool _isDownload = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<MarchantData>(
        stream: DatabaseService().Marchant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final marchantdata = snapshot.data;
            return Stack(
              children: [
                Container(
                  height: size.height * 0.8,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            // height: 30,
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 8),
                            width: size.width * 0.75,
                            color: Colors.grey.shade300,
                            child: _textUtils.bold14(
                                "Total amount: Rs.${widget.order.amount.toStringAsFixed(0)}",
                                Colors.black),
                          ),
                          Container(
                            width: size.width * 0.75,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        _textUtils.bold14(
                                            "DELIVERY ADDRESS:", Colors.black),
                                        Container(
                                          width: size.width * 0.39,
                                          child: _textUtils.bold12over(
                                              "${widget.order.user_address1}",
                                              Colors.grey),
                                        ),
                                        _textUtils.bold12(
                                            "${widget.order.user_address2}, ${widget.order.user_city} ",
                                            Colors.grey),
                                        _textUtils.bold12(
                                            "${widget.order.user_state} - ${widget.order.user_zipcode}",
                                            Colors.grey),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      height: 1,
                                      width: 150,
                                      color: Colors.grey.shade300,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        _textUtils.bold14(
                                            "PICKUP ADDRESS:", Colors.black),
                                        Container(
                                          width: size.width * 0.39,
                                          child: _textUtils.bold12over(
                                              "${marchantdata!.addreess}",
                                              Colors.grey),
                                        ),
                                        _textUtils.bold12(
                                            "${marchantdata.sublocality}, ${marchantdata.city}",
                                            Colors.grey),
                                        _textUtils.bold12(
                                            "${marchantdata.state} - ${marchantdata.zipCode}",
                                            Colors.grey),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                    Container(
                                      height: 140,
                                      width: 140,
                                      child: SfBarcodeGenerator(
                                        value: '${widget.order.uid}',
                                        symbology: QRCode(),
                                        barColor: Colors.black,
                                        // showValue: true,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: size.width * 0.75,
                            height: 1,
                            color: Colors.grey.shade300,
                          ),
                          Container(
                            width: size.width * 0.75,
                            // height: 40,
                            // color: Colors.grey.shade300,
                            child: Card(
                              elevation: 0,
                              color: Colors.grey.shade300,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 25, 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Courier Name :",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              " E-Abc Logistics",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "HBD: ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "15 - 09",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Courier AWB No : ",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "HJGSFUHDGKL",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "CPD: ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "${_dateFormat.format(widget.order.delivery_expected_date!)}",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            // height: 76,

                            width: size.width * 0.76,
                            decoration: BoxDecoration(
                                border: Border.all(
                              width: 1,
                              color: Colors.black,
                            )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sold By: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                    ),
                                    Container(
                                      width: size.width * 0.62,
                                      child: Text(
                                        "${widget.order.name}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 10),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  // height: 20,
                                  width: size.width * 0.75,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  )),
                                  child: Row(
                                    children: [
                                      Text(
                                        "GSTIN No:",
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            // height: 20,
                            width: size.width * 0.75,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _textUtils.bold14(
                                            "Product", Colors.black),
                                        _textUtils.bold14("Qut", Colors.black),
                                      ],
                                    ),
                                    Divider(
                                      // height: 5,
                                      thickness: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width * 0.6,
                                          child: _textUtils.normal12(
                                              "${widget.order.name}${widget.order.productname}-${widget.order.productId}",
                                              Colors.black),
                                        ),
                                        _textUtils.normal14(
                                            "${widget.order.quantity.toStringAsFixed(0)}",
                                            Colors.black),
                                      ],
                                    ),
                                    Divider(
                                      // height: 5,
                                      thickness: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: size.width * 0.6,
                                          child: _textUtils.bold14(
                                              "Total", Colors.black),
                                        ),
                                        _textUtils.normal14(
                                            "${widget.order.quantity.toStringAsFixed(0)}",
                                            Colors.black),
                                      ],
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 40,
                                  child: Container(
                                    height: 100,
                                    width: 0.5,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 2,
                            width: size.width * 0.95,
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: size.width * 0.9,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 15),
                                  color: Colors.black,
                                  child: _textUtils.bold14(
                                      "Handover to Username", Colors.white),
                                ),
                                _textUtils.bold14("STD", Colors.black),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              _textUtils.bold12("Tracking ID:", Colors.black),
                              SizedBox(
                                width: 5,
                              ),
                              _textUtils.normal12(
                                  "${widget.order.productId}".toUpperCase(),
                                  Colors.black),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 35),
                            height: 50,
                            width: size.width * 0.5,
                            child: SfBarcodeGenerator(
                              value: '${widget.order.productId}',
                              symbology: Code128C(module: 1),
                              barColor: Colors.black,
                              // showValue: true,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              _textUtils.bold12("Order ID:", Colors.black),
                              SizedBox(
                                width: 5,
                              ),
                              _textUtils.normal12(
                                  "${widget.order.uid}".toUpperCase(),
                                  Colors.black),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: size.width * 0.1,
                        top: size.height * 0.2,
                        // bottom: s,
                        child: Container(
                          height: 60,
                          width: 0,
                          child: Transform.rotate(
                            angle: pi / 2,
                            child: SfBarcodeGenerator(
                              value: '${widget.order.uid}',
                              symbology: Code128(module: 1),
                              barColor: Colors.black,
                              // showValue: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 15,
                  child: FloatingActionButton(
                    onPressed: () async {
                      setState(() {
                        _isDownload = true;
                      });
                      final res = getDocument(
                          context: context,
                          addreess: "",
                          sublocality: "sublocality",
                          city: "${marchantdata.city}",
                          state: "${marchantdata.state}",
                          zipCode: "${marchantdata.zipCode}",
                          order: widget.order);
                      final data = await res.save();
                      File file = File(
                          (await getExternalStorageDirectory())!.path +
                              "/" +
                              "${widget.order.uid}.pdf");
                      await file.writeAsBytes(data);
                      print(file.path);
                      setState(() {
                        _isDownload = false;
                      });
                    },
                    child: _isDownload
                        ? Container(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(),
                          )
                        : Icon(Icons.download),
                  ),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
