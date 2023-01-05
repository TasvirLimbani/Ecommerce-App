// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class PlantModel {
  List plant_Image = [];
  String plant_Name = "";
  String plant_Mrp = "";
  String plant_Price = "";
  String plant_Quntity = "";
  String plant_Details = "";
  String net_quantity = "";
  String plant_weight = "";
  String country = "";
  String manufacturer = "";
  String marchant_name = "";
  String marchant_image = "";
  String marchant_id = "";
  bool plant_Sun = false;
  bool plant_Air = false;
  bool plant_Small = false;
  bool plant_Water = false;
  bool plant_boost = false;
  DateTime? plant_date;
  String uid = "";

  PlantModel.fromSnapShort(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map;
    Timestamp date = data['plant_date'];
    plant_Image =
        (data['plant_image'] as List).map((e) => e.toString()).toList();
    plant_Name = data['plant_name'];
    plant_Mrp = data['plant_mrp'];
    plant_Price = data['plant_price'];
    plant_Quntity = data['plant_quantity'];
    marchant_name = data['marchant_name'];
    marchant_image = data['marchant_image'];
    marchant_id = data['marchant_id'];
    net_quantity = data['net_quantity'];
    plant_weight = data['weight'];
    country = data['country'];
    manufacturer = data['manufacturer'];
    plant_Details = data['plant_detail'];
    plant_Air = data['plant_air'];
    plant_Sun = data['plant_sun'];
    plant_Water = data['plant_water'];
    plant_Small = data['plant_small'];
    plant_boost = data['boost'];
    plant_date = date.toDate();
    uid = snapshot.id;
  }
}
