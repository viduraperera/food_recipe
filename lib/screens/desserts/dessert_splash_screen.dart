import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

class DessertSplashScreen extends StatefulWidget {
  const DessertSplashScreen({Key? key}) : super(key: key);

  @override
  State<DessertSplashScreen> createState() => _DessertSplashScreenState();
}

class _DessertSplashScreenState extends State<DessertSplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() async {
    //adding duration to the splash screen
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => MealList()),
              (r) => false);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image(
                  image: AssetImage("assets/images/1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )

      ),

    );
  }
}
