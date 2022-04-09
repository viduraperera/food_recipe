import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/models/dessert_item.dart';

class FeatureImageDessert extends StatelessWidget {
  final DessertItem item;
  const FeatureImageDessert({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double r = UIManager.ratio;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 3,
      child: SizedBox(
        height: 160 * r,
        width: (w / 1.5) * r,
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerLeft,
                    colors: <Color>[Colors.grey, Colors.transparent]),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.memory(base64Decode(item.dessertImage),
                      fit: BoxFit.cover)),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20 * r, top: 20 * r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.subTitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15 * r,
                          fontWeight: FontWeight.bold)),
                  Text(
                    item.dessertName,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24 * r,
                        fontWeight: FontWeight.bold),
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
