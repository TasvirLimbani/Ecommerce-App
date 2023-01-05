import 'package:flutter/material.dart';

class ConfirmationScreen extends StatefulWidget {
  String name;
  String title;
  Icon icon;
  Color color;
  ConfirmationScreen(
      {required this.name,
      Key? key,
      required this.icon,
      required this.color,
      this.title = "Great!"})
      : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Center(
            child: Container(
              width: size.width * .9,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[100],
              ),
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: widget.color, shape: BoxShape.circle),
                        child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: widget.icon),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.title,
                        style: (TextStyle(
                            letterSpacing: 1,
                            fontSize: 23,
                            fontFamily: 'semiBold')),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'bold',
                            height: 1.5,
                            color: Color(0xff454545),
                            letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}