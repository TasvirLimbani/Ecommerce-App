import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:plant_app/Marchant/Models/orderModel.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

Document getDocument({
  required BuildContext context,
  required String addreess,
  required String sublocality,
  required String city,
  required String state,
  required String zipCode,
  required MarchantOrderModel order,
}) {
  final pdf = Document();
  final size = MediaQuery.of(context).size;
  TextUtils textUtils = TextUtils();
  DateTime _datetime = DateTime.now();
  DateFormat _dateFormat = DateFormat.Md();
  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (con) {
        return pw.Container(
          child: pw.Container(
            // height: size.height * 0.8,
            decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            padding: pw.EdgeInsets.symmetric(horizontal: 8),
            child: pw.Stack(
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Container(
                      // height: 30,
                      padding:
                          pw.EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      width: size.width * 0.75,
                      color: PdfColors.grey,
                      child: pw.Text(
                          "Total amount: Rs.${order.amount.toStringAsFixed(0)}",
                          style: pw.TextStyle(
                              color: PdfColors.black,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 14)),
                    ),
                    pw.Container(
                      width: size.width * 0.75,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Column(
                            children: [
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "DELIVERY ADDRESS:",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 14,
                                        color: PdfColors.black),
                                  ),
                                  // _textUtils.bold14(
                                  //     "DELIVERY ADDRESS:", PdfColors.black),
                                  pw.Container(
                                    width: size.width * 0.39,
                                    child: pw.Text(
                                      "${order.user_address1}",
                                      // overflow: TextOverflow.ellipsis,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 12,
                                          color: PdfColors.grey),
                                      // _textUtils.bold12over(
                                      //     "${order.user_address1}", PdfColors.grey),
                                    ),
                                  ),
                                  pw.Text(
                                    "${order.user_address2}, ${order.user_city} ",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 12,
                                        color: PdfColors.grey),
                                  ),
                                  // _textUtils.bold12(
                                  //     "${order.user_address2}, ${order.user_city} ",
                                  //     PdfColors.grey),
                                  pw.Text(
                                    "${order.user_state} - ${order.user_zipcode}",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 12,
                                        color: PdfColors.grey),
                                  ),
                                  // _textUtils.bold12(
                                  //     "${order.user_state} - ${order.user_zipcode}",
                                  //     PdfColors.grey),
                                ],
                              ),
                              pw.Container(
                                margin: pw.EdgeInsets.symmetric(vertical: 8),
                                height: 1,
                                width: 150,
                                color: PdfColors.black,
                              ),
                              pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "PICKUP ADDRESS:",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 14,
                                        color: PdfColors.black),
                                  ),
                                  // _textUtils.bold14(
                                  //     "PICKUP ADDRESS:", PdfColors.black),
                                  pw.Container(
                                    width: size.width * 0.39,
                                    child: pw.Text(
                                      "${addreess}",
                                      maxLines: 2,
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 12,
                                          color: PdfColors.grey),
                                    ),
                                    // _textUtils.bold12over(
                                    //     "${marchantdata!.addreess}",
                                    //     PdfColors.grey),
                                  ),
                                  pw.Text(
                                    "${sublocality}, ${city}",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 12,
                                        color: PdfColors.grey),
                                  ),
                                  // _textUtils.bold12(
                                  //     "${marchantdata.sublocality}, ${marchantdata.city}",
                                  //     PdfColors.grey),
                                  pw.Text(
                                    "${state} - ${zipCode}",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 12,
                                        color: PdfColors.grey),
                                  ),
                                  // _textUtils.bold12(
                                  //     "${marchantdata.state} - ${marchantdata.zipCode}",
                                  //     PdfColors.grey),
                                ],
                              ),
                            ],
                          ),
                          // pw.Row(
                          //   mainAxisSize: pw.MainAxisSize.min,
                          //   children: [
                          //     pw.Container(
                          //       height: 150,
                          //       width: 1,
                          //       color: PdfColors.grey,
                          //     ),
                          //     pw.Container(
                          //       height: 140,
                          //       width: 140,
                          //       child: pw.SfBarcodeGenerator(
                          //         value: '${order.uid}',
                          //         symbology: QRCode(),
                          //         barColor: PdfColors.black,
                          //         // showValue: true,
                          //       ),
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    pw.Container(
                      width: size.width * 0.75,
                      height: 1,
                      color: PdfColors.grey,
                    ),
                    pw.Container(
                      width: size.width * 0.75,
                      // height: 40,
                      // color: PdfColors.grey.shade300,
                      child: pw.Container(
                        decoration: pw.BoxDecoration(
                          color: PdfColors.grey,
                          borderRadius: pw.BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: pw.Padding(
                          padding: pw.EdgeInsets.fromLTRB(10, 10, 25, 10),
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Text(
                                        "Courier Name :",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                        " E-Abc Logistics",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Row(
                                    children: [
                                      pw.Text(
                                        "HBD: ",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "15 - 09",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Row(
                                    children: [
                                      pw.Text(
                                        "Courier AWB No : ",
                                        style: pw.TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      pw.Text(
                                        "HJGSFUHDGKL",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  pw.Row(
                                    children: [
                                      pw.Text(
                                        "CPD: ",
                                        style: pw.TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      pw.Text(
                                        "${_dateFormat.format(order.delivery_expected_date!)}",
                                        style: pw.TextStyle(
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
                    pw.Container(
                      padding: pw.EdgeInsets.all(5),
                      // height: 76,

                      width: size.width * 0.76,
                      decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                        width: 1,
                        color: PdfColors.black,
                      )),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                "Sold By: ",
                                style: pw.TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 10),
                              ),
                              pw.Container(
                                width: size.width * 0.62,
                                child: pw.Text(
                                  "${order.name}",
                                  // overflow: pw.TextOverflow,
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                  style: pw.TextStyle(fontSize: 10),
                                ),
                              )
                            ],
                          ),
                          pw.SizedBox(
                            height: 5,
                          ),
                          pw.Container(
                            padding: pw.EdgeInsets.all(10),
                            // height: 20,
                            width: size.width * 0.75,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                              width: 1,
                              color: PdfColors.black,
                            )),
                            child: pw.Row(
                              children: [
                                pw.Text(
                                  "GSTIN No:",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                pw.Text(
                                  "ASFJGF44DDFKHIJNKDSF84DFISHDUIFHSF8",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Container(
                      padding: pw.EdgeInsets.all(10),
                      // height: 20,
                      width: size.width * 0.75,
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(
                          width: 2,
                          color: PdfColors.black,
                        ),
                      ),
                      child: pw.Stack(
                        children: [
                          pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(
                                    "Product",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 14,
                                        color: PdfColors.black),
                                  ),
                                  // _textUtils.bold14("Product", PdfColors.black),
                                  pw.Text(
                                    "Qut",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 14,
                                        color: PdfColors.black),
                                  ),
                                  // _textUtils.bold14("Qut", PdfColors.black),
                                ],
                              ),
                              pw.Divider(
                                // height: 5,
                                thickness: 1,
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Container(
                                    width: size.width * 0.6,
                                    child: pw.Text(
                                      "${order.name}${order.productname}-${order.productId}",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.normal,
                                          fontSize: 12,
                                          color: PdfColors.black),
                                    ),
                                    // _textUtils.normal12(
                                    //     "${order.name}${order.productname}-${order.productId}",
                                    //     PdfColors.black),
                                  ),
                                  pw.Text(
                                    "${order.quantity.toStringAsFixed(0)}",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                        fontSize: 14,
                                        color: PdfColors.black),
                                  ),
                                  // _textUtils.normal14(
                                  //     "${order.quantity.toStringAsFixed(0)}",
                                  //     PdfColors.black),
                                ],
                              ),
                              pw.Divider(
                                // height: 5,
                                thickness: 1,
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Container(
                                    width: size.width * 0.6,
                                    child: pw.Text(
                                      "Total",
                                      style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 14,
                                          color: PdfColors.black),
                                    ),
                                    // _textUtils.bold14(
                                    //     "Total", PdfColors.black),
                                  ),
                                  pw.Text(
                                    "${order.quantity.toStringAsFixed(0)}",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 14,
                                        color: PdfColors.black),
                                  ),
                                  // _textUtils.normal14(
                                  //     "${order.quantity.toStringAsFixed(0)}",
                                  //     PdfColors.black),
                                ],
                              ),
                            ],
                          ),
                          pw.Positioned(
                            right: 40,
                            child: pw.Container(
                              height: 100,
                              width: 0.5,
                              color: PdfColors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Container(
                      height: 2,
                      width: size.width * 0.95,
                      color: PdfColors.black,
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Container(
                      width: size.width * 0.9,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                            padding: pw.EdgeInsets.symmetric(
                                vertical: 8, horizontal: 15),
                            color: PdfColors.black,
                            child: pw.Text(
                              "Handover to Username",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 14,
                                  color: PdfColors.white),
                            ),
                            // _textUtils.bold14(
                            //     "Handover to Username", PdfColors.white),
                          ),
                          pw.Text(
                            "STD",
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 14,
                                color: PdfColors.black),
                          ),
                          // _textUtils.bold14("STD", PdfColors.black),
                        ],
                      ),
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          "Tracking ID:",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                              color: PdfColors.black),
                        ),
                        // _textUtils.bold12("Tracking ID:", PdfColors.black),
                        pw.SizedBox(
                          width: 5,
                        ),
                        pw.Text(
                          "${order.productId}".toUpperCase(),
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 12,
                              color: PdfColors.black),
                        ),
                        // _textUtils.normal12(
                        //     "${order.productId}".toUpperCase(), PdfColors.black),
                      ],
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    // pw.Container(
                    //   margin: pw.EdgeInsets.only(left: 35),
                    //   height: 50,
                    //   width: size.width * 0.5,
                    //   child: pw.SfBarcodeGenerator(
                    //     value: '${order.productId}',
                    //     symbology: Code128C(module: 1),
                    //     barColor: PdfColors.black,
                    //     // showValue: true,
                    //   ),
                    // ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          "Order ID:",
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 12,
                              color: PdfColors.black),
                        ),
                        // _textUtils.bold12("Order ID:", PdfColors.black),
                        pw.SizedBox(
                          width: 5,
                        ),
                        pw.Text(
                          "${order.uid}".toUpperCase(),
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 12,
                              color: PdfColors.black),
                        ),
                        // _textUtils.normal12(
                        //     "${order.uid}".toUpperCase(), PdfColors.black),
                      ],
                    ),
                  ],
                ),
                // pw.Positioned(
                //   right: size.width * 0.1,
                //   top: size.height * 0.2,
                //   // bottom: s,
                //   child: pw.Container(
                //     height: 60,
                //     width: 0,
                //     child: pw.Transform.rotate(
                //       angle: pi / 2,
                //       child: pw.SfBarcodeGenerator(
                //         value: '${order.uid}',
                //         symbology: Code128(module: 1),
                //         barColor: PdfColors.black,
                //         // showValue: true,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return pdf;
}
