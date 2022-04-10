import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:food_recipe/providers/dessert_provider.dart';
import 'package:provider/provider.dart';

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
    final rpDessertdl = Provider.of<DessertProvider>(context, listen: false);
    await rpDessertdl.loadAllDesserts();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => DessertList()),
        (r) => false);
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
              image: AssetImage("assets/images/2.png"),
              fit: BoxFit.cover,
            ),
          ),
        ],
      )),
    );
  }
}
