// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

class MealCardLarge extends StatelessWidget {
  final MealItem item;
  const MealCardLarge({Key? key, required this.item}) : super(key: key);

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
                image: NetworkImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 18 * r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.name,
                      style: TextStyle(
                          color: kGrey1,
                          fontWeight: FontWeight.bold,
                          fontSize: 20 * r),
                    ),
                    Text(
                      item.subTitle,
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
