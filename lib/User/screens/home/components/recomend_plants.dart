import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/plant.dart';
import 'package:plant_app/User/screens/details/details_screen.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/utils/Text_utils.dart';

class RecomendsPlants extends StatelessWidget {
  const RecomendsPlants({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<List<PlantModel>>(
        stream: DatabaseService().plant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Container(
              height: size.height * 0.36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return data[index].plant_boost
                      ? GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      uid: data[index].uid,
                                    )));
                          },
                          child: RecomendPlantCard(
                            image: data[index].plant_Image,
                            title: data[index].plant_Name,
                            mrp: data[index].plant_Mrp,
                            price: data[index].plant_Price,
                            date: data[index].plant_date,
                            sun: data[index].plant_Sun,
                            small: data[index].plant_Small,
                            water: data[index].plant_Water,
                            air: data[index].plant_Air,
                          ),
                        )
                      : Container();
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class RecomendPlantCard extends StatelessWidget {
  RecomendPlantCard({
    Key? key,
    required this.image,
    required this.title,
    required this.mrp,
    required this.price,
    required this.sun,
    required this.air,
    required this.small,
    required this.water,
    required this.date,
    // required this.press,
  }) : super(key: key);

  final String title, mrp;
  List image;
  DateTime? date;
  bool sun, air, water, small = false;
  final String price;
  // final Function() press;
  final TextUtils _textUtils = TextUtils();
  DateFormat dateFormat = DateFormat('EEE, MMM d, ' 'y');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      // onTap: press,
      child: Container(
        margin: const EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                // image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover)
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(image.first, fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                  return child;
                }, loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor.withOpacity(0.4),
                      ),
                    );
                  }
                }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: 75,
                          child: _textUtils.bold16max(
                              "$title".toUpperCase(), Colors.black)),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _textUtils.bold12throw(
                              "$mrp ", Colors.red.withOpacity(0.5)),
                          _textUtils.bold16("$price", primaryColor),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
