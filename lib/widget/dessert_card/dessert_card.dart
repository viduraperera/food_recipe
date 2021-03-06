// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

import '../../models/dessert_item.dart';

class DessertCard extends StatelessWidget {
  final Dessert item;
  const DessertCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double r = UIManager.ratio;


    return GestureDetector(
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (h / 4.3) * r,
              width: w,
              padding: EdgeInsets.only(
                  left: 18 * r, right: 18 * r, top: 12 * r, bottom: 10 * r),
              child: Image(
                image: NetworkImage(item.data.dessertImage),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 18 * r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.data.dessertName,
                    style: TextStyle(
                        color: kGrey1,
                        fontWeight: FontWeight.bold,
                        fontSize: 20 * r),
                  ),
                  Text(
                    item.data.subTitle,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
