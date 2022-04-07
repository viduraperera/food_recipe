import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  List<String> imageList = [
    "https://firebasestorage.googleapis.com/v0/b/ctse-food-recipe.appspot.com/o/main%2F1.png?alt=media&token=12be9c23-3561-40a4-b5b2-cd29a812bd5b.png",
    "https://firebasestorage.googleapis.com/v0/b/ctse-food-recipe.appspot.com/o/main%2FbakedSplash.jpg?alt=media&token=9a289f9a-5f48-4ea2-bb3c-9835867ed100",
    "https://firebasestorage.googleapis.com/v0/b/ctse-food-recipe.appspot.com/o/main%2F2.png?alt=media&token=d1f21619-6b8a-48b4-8629-aa54e144eb34.png",
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "My Recipe Book",
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                  height: 500,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enableInfiniteScroll: false,
                ),
                itemCount: 3,
                itemBuilder: (context, index, realIndex) {
                  final singleImage = imageList[index];
                  Widget widget = MealSplashScreen();
                  if (index == 1) {
                    widget = BakedSplashScreen();
                  } else if (index == 2) {
                    widget = DessertList();
                  }
                  return mealImage(singleImage, index, context, widget);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mealImage(String singleImage, int index, context, widgetN) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: Material(
            child: Ink.image(
              image: NetworkImage(imageList[index]),
              fit: BoxFit.cover,
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widgetN,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
