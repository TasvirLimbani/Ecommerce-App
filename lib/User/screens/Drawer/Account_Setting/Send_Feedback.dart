import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plant_app/User/Service/Firebase_Query.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/utils/Text_utils.dart';

class FeedBackScreen extends StatefulWidget {
  const FeedBackScreen({Key? key}) : super(key: key);

  @override
  State<FeedBackScreen> createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  TextUtils _textUtils = TextUtils();
  TextEditingController _feedbackController = TextEditingController();
  int currentIndex = 0;
  bool send = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _textUtils.bold18("Send Feedback", Colors.white),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              _textUtils.normal20("Rate Your Experience", Colors.black),
              const SizedBox(
                height: 10,
              ),
              _textUtils.normal10(
                  "Are you Satisfied with the Service?", Colors.grey),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 60,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: currentIndex >= index
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: const Icon(
                                Icons.star_rate_rounded,
                                size: 50,
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
                                size: 50,
                                color: Colors.grey,
                              ),
                            ),
                    );
                  },
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              _textUtils.bold14("Tell us what can be Improved?", Colors.black),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Improved.length * 30,
                child: GridView.builder(
                  itemCount: Improved.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          SelectedInt.contains(Improved[index].name)
                              ? SelectedInt.remove(Improved[index].name)
                              : SelectedInt.add(Improved[index].name);
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: SelectedInt.contains(Improved[index].name)
                                ? primaryColor
                                : Colors.grey.shade300),
                        child: Center(
                          child: _textUtils.bold14(
                              Improved[index].name,
                              SelectedInt.contains(Improved[index].name)
                                  ? Colors.white
                                  : Colors.grey.shade800),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 160,
                child: TextFormField(
                  controller: _feedbackController,
                  textInputAction: TextInputAction.go,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: primaryColor),
                  maxLines: 10,
                  textAlign: TextAlign.start,
                  decoration: InputDecoration(
                      hintText: "Tell us on how can we improve.....",
                      labelText: "Tell us on how can we improve",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: send
                      ? null
                      : () async {
                          setState(() {
                            send = true;
                          });
                          Timer(Duration(seconds: 2), () async {
                            await FirebaseQuery.firebaseQuery.sendFeedback(
                                FirebaseAuth.instance.currentUser!.uid, {
                              'userId': FirebaseAuth.instance.currentUser!.uid,
                              "feedback": _feedbackController.text,
                              'rating': currentIndex + 1,
                              "improved": SelectedInt,
                              'date': DateTime.now(),
                              'solve': false
                            }).then((value) {
                              setState(() {
                                send = false;
                              });
                              Navigator.of(context).pop();
                            });
                          });
                        },
                  child: Container(
                    width: 200,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color:
                          send ? primaryColor.withOpacity(0.4) : primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: send
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white60,
                                    strokeWidth: 2,
                                  )),
                              SizedBox(
                                width: 10,
                              ),
                              _textUtils.bold16("Submit Feedback", Colors.white)
                            ],
                          )
                        : Center(
                            child: _textUtils.bold16(
                                "Submit Feedback", Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class improve {
  String name;
  improve({required this.name});
}

List<improve> Improved = [
  improve(name: "Overall Service"),
  improve(name: "Customer Support"),
  improve(name: "Speed and Efficiency"),
  improve(name: "Repair Quality"),
  improve(name: "Pickup and Delivery Speed"),
  improve(name: "Transperancy"),
];

List SelectedInt = [];
