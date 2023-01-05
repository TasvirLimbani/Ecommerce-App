import 'package:flutter/material.dart';
import 'package:plant_app/Marchant/Models/orderModel.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/order_model.dart';
import 'package:plant_app/pdf/label.dart';
import 'package:plant_app/utils/Text_utils.dart';

class MarchantOrders extends StatefulWidget {
  const MarchantOrders({Key? key}) : super(key: key);

  @override
  State<MarchantOrders> createState() => _MarchantOrdersState();
}

class _MarchantOrdersState extends State<MarchantOrders> {
  final TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MarchantOrderModel>>(
        stream: DatabaseService().marchantorderlist,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orderdata = snapshot.data;
            return Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: orderdata!.isEmpty
                  ? Center(
                      child: Image.network(
                          'https://cdni.iconscout.com/illustration/premium/thumb/man-receiving-canceled-orders-back-4438793-3718471.png'),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: orderdata.length,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return OrderLabel(
                                    order: orderdata[index],
                                  );
                                },
                              );
                            },
                            leading: Container(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  orderdata[index]
                                      .productimage
                                      .first
                                      .toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: _textUtils.bold18(
                                orderdata[index].productname, Colors.black),
                            subtitle: _textUtils.bold14(
                                "quantity : ${orderdata[index].quantity.toString().split(".").first}",
                                Colors.grey.shade700),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: const Color(0xFF303030),
                              size: 20,
                            ),
                            tileColor: const Color(0xFFF5F5F5),
                            dense: false,
                          ),
                        );
                      },
                    ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
