import 'package:flutter/material.dart';
import 'package:plant_app/User/Service/Firebase_data.dart';
import 'package:plant_app/User/models/plant.dart';
import 'package:plant_app/User/screens/details/details_screen.dart';
import 'package:plant_app/constant/Color.dart';
import 'package:plant_app/constant/buy_now_button.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/utils/Text_utils.dart';

class FeaturedPlants extends StatelessWidget {
  const FeaturedPlants({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<List<PlantModel>>(
        stream: DatabaseService().plant,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final plantdata = snapshot.data;
            return Container(
              height: size.height * 0.25,
              child: ListView.builder(
                itemCount: plantdata!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return plantdata[index].plant_boost
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                      uid: plantdata[index].uid,
                                    )));
                          },
                          child: FeaturePlantCard(
                            plantModel: plantdata[index],
                          ),
                        );
                },
              ),
            );
          }
          return const Center(
            child: const CircularProgressIndicator(),
          );
        });
  }
}

class FeaturePlantCard extends StatefulWidget {
  FeaturePlantCard({
    Key? key,
    required this.plantModel,
    // required this.press,
  }) : super(key: key);
  PlantModel plantModel;

  @override
  State<FeaturePlantCard> createState() => _FeaturePlantCardState();
}

class _FeaturePlantCardState extends State<FeaturePlantCard> {
  // final Function() press;
  final TextUtils _textUtils = TextUtils();

  double discount = 0;

  bool buyNow = false;
  bool like = false;

  void sum(int price, int mrp) {
    discount = (price * 100) / mrp - 100;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    sum(int.parse(widget.plantModel.plant_Price),
        int.parse(widget.plantModel.plant_Mrp));
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: kDefaultPadding,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2,
          ),
          width: size.width * 0.5,
          height: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.black),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: NetworkImage(widget.plantModel.plant_Image.first),
            // ),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomLeft: Radius.circular(6)),
                  child: Image.network(widget.plantModel.plant_Image.first,
                      fit: BoxFit.cover, frameBuilder:
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
              Positioned(
                right: 1,
                top: 1,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      like = !like;
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        like ? Icons.favorite : Icons.favorite_border,
                        color: like ? Colors.red : Colors.black,
                      )),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            // left: 5,
            top: kDefaultPadding / 2,
            bottom: kDefaultPadding / 2,
          ),
          width: size.width * 0.4,
          // height: 185,
          decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.black),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              color: Colors.grey.shade300),
          padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _textUtils.bold18Over(
                  widget.plantModel.plant_Name, Colors.grey.shade800),
              const SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _textUtils.bold12("Offer : ", primaryColor),
                  _textUtils.bold12throw("${widget.plantModel.plant_Mrp} ",
                      Colors.red.withOpacity(0.5)),
                  _textUtils.bold16(
                      "${widget.plantModel.plant_Price}", primaryColor),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              _textUtils.bold14(
                  "Net Quantity : ${widget.plantModel.net_quantity}",
                  Colors.grey.shade800),
              const SizedBox(
                height: 5,
              ),
              _textUtils.bold14("Weight : ${widget.plantModel.plant_weight}",
                  Colors.grey.shade800),
              const SizedBox(
                height: 5,
              ),
              _textUtils.bold14("Country : ${widget.plantModel.country}",
                  Colors.grey.shade800),
              const SizedBox(
                height: 5,
              ),
              BuyNowButton(
                onTap: () {
                  setState(() {
                    buyNow = true;
                  });
                },
                buyNow: buyNow,
                padding: const EdgeInsets.symmetric(vertical: 8),
                containerweight: 100,
                containerheight: 34,
                fontsize: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
