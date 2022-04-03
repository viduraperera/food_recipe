import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

class MainScreen extends StatelessWidget {

  MainScreen({Key? key}) : super(key: key);

  List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/ctse-food-recipe.appspot.com/o/main%2F1.png?alt=media&token=12be9c23-3561-40a4-b5b2-cd29a812bd5b.png",
    "https://firebasestorage.googleapis.com/v0/b/ctse-food-recipe.appspot.com/o/main%2F3.png?alt=media&token=db43eaae-3c23-4c53-8241-78506446954a.png",
    "https://firebasestorage.googleapis.com/v0/b/ctse-food-recipe.appspot.com/o/main%2F2.png?alt=media&token=d1f21619-6b8a-48b4-8629-aa54e144eb34.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: CarouselSlider.builder(
            options: CarouselOptions(
              height: 500,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enableInfiniteScroll: false,
            ),
            itemCount: 3,
            itemBuilder: (context, index, realIndex) {
              final singleImage = imageList[index];
              Widget widget = MealList();
              if (index == 1) {
                widget = Container();
              }
              else if (index == 2) {
                widget = Container();
              }
              return mealImage(singleImage, index, context, widget);
            },
          ),
        ),
      ),
    );
  }

  Widget mealImage(String singleImage, int index, context, widgetN) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 4),
        color: Colors.grey,
        child: Material(
          child: Ink.image(
            image: NetworkImage(imageList[index]),
            fit: BoxFit.cover,
            child: InkWell(
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widgetN,
                    ),
                  ),
            ),
          ),
        ),
      );
}
