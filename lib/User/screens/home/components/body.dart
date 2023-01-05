import 'package:flutter/material.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/constants.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return StreamBuilder<UserData>(
      stream: DatabaseService().User,
      builder: (context, snapshot) {
        final userdata = snapshot.data;
        if(snapshot.hasData){
          return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HeaderWithSearchBox(size: size, name: userdata!.name , image: userdata.profileUrl),
              TitleWithMoreBtn(title: "Recomended", press: () {}),
              RecomendsPlants(),
              TitleWithMoreBtn(title: "Featured Plants", press: () {}),
              FeaturedPlants(),
              SizedBox(height: kDefaultPadding),
            ],
          ),
        );
        }
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        return Center(child: CircularProgressIndicator());
      }
    );
  }
}
