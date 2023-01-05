import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/user.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';
import 'package:scratcher/widgets.dart';

class MyRewards extends StatefulWidget {
  const MyRewards({Key? key}) : super(key: key);

  @override
  State<MyRewards> createState() => _MyRewardsState();
}

class _MyRewardsState extends State<MyRewards> {
  final scratchkey = GlobalKey<ScratcherState>();
  TextUtils _textUtils = TextUtils();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<UserData>(
        stream: DatabaseService().User,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userdata = snapshot.data;
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: userdata!.total_reward,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(
                        left: index.isOdd ? 5 : 10,
                        right: index.isEven ? 5 : 10,
                        top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor,
                    ),
                    child: Scratcher(
                      
                      // enabled: false,
                      brushSize: 50,
                      threshold: 50,
                      color: Colors.grey,
                      onChange: (value) {
                        setState(() {
                          value > 50
                              ? scratchkey.currentState?.reveal(
                                  duration: Duration(milliseconds: 2000))
                              : null;
                        });

                        print("Scratch progress: $value%");
                        // setState(() {
                        //   value > 40 ? value = 100 : value = value;
                        // });
                        // value>65?FirebaseQuery.firebaseQuery.updateUser({"rewards":userdata.rewards-1}):null;
                        // value == 100
                        //     ? FirebaseQuery.firebaseQuery.updateUser({
                        //         "rewards": {
                        //           "total_reward": 4,
                        //           "first": {
                        //             "first_discount":
                        //                 userdata.first_discount,
                        //             "first_open": index==0?true:false,
                        //             "first_date": userdata.first_date
                        //           },
                        //           "second": {
                        //             "second_discount":
                        //                 userdata.second_discount,
                        //             "second_open": index==1?true:false,
                        //             "second_date": userdata.second_date,
                        //           },
                        //           "third": {
                        //             "third_discount":
                        //                 userdata.third_discount,
                        //             "third_open":index==2?true:false,
                        //             "third_date": userdata.third_date
                        //           },
                        //           "fourth": {
                        //             "fourth_discount":
                        //                 userdata.fourth_discount,
                        //             "fourth_open": index==3?true:false,
                        //             "fourth_date": userdata.fourth_date
                        //           },
                        //         },
                        //       })
                        //     : null;
                        value == 100
                            ? showDialog(
                                context: context,
                                builder: (context) {
                                  return CongratulationsScreen(
                                    name: index == 0
                                        ? userdata.first_discount
                                        : index == 1
                                            ? userdata.second_discount
                                            : index == 2
                                                ? userdata.third_discount
                                                : userdata.fourth_discount,
                                  );
                                })
                            : null;
                      },
                      onThreshold: () => print("Threshold reached, you won!"),
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: primaryColor,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/trophy.svg",
                                  height: 50),
                              const SizedBox(
                                height: 10,
                              ),
                              _textUtils.bold12("YOU WON", Colors.white),
                              const SizedBox(
                                height: 5,
                              ),
                              _textUtils.bold18(
                                  index == 0
                                      ? userdata.first_discount
                                      : index == 1
                                          ? userdata.second_discount
                                          : index == 2
                                              ? userdata.third_discount
                                              : userdata.fourth_discount,
                                  Colors.white)
                            ]),
                        // height: 300,
                        // width: 300,
                      ),
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
            );
          }
          return const Center(
            child: const CircularProgressIndicator(),
          );
        });
  }
}

class CongratulationsScreen extends StatefulWidget {
  final String name;
  const CongratulationsScreen({Key? key, required this.name}) : super(key: key);

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  late ConfettiController _controllerCenter;
  TextUtils _textUtils = TextUtils();
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    _controllerCenter.play();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            // shouldLoop: true,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            createParticlePath: drawStar,
          ),
        ),
        Center(
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: primaryColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _textUtils.bold18(
                    "Congratulations".toUpperCase(), Colors.white),
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SvgPicture.asset("assets/icons/trophy.svg", height: 100),
                  const SizedBox(
                    height: 15,
                  ),
                  // _textUtils.bold14("YOU WON", Colors.white),
                  // const SizedBox(
                  //       height: 5,
                  // ),
                  _textUtils.bold18("YOU WON ${widget.name}", Colors.white)
                ]),
                Container(
                  child: _textUtils.bold14(
                      "This Rewards Valid To ${dateTime.day + 5}",
                      Colors.white38),
                ),
              ],
            ),
            // height: 300,
            // width: 300,
          ),
        ),
      ],
    );
  }
}
