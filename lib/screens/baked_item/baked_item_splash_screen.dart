import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';
import 'package:provider/provider.dart';

class BakedSplashScreen extends StatefulWidget {
  const BakedSplashScreen({Key? key}) : super(key: key);

  @override
  State<BakedSplashScreen> createState() => _BakedSplashScreenState();
}

class _BakedSplashScreenState extends State<BakedSplashScreen> {
  @override
  void initState() {
    super.initState();
    navigate();
  }

  navigate() async {
    //adding duration to the splash screen
    final rpMdl = Provider.of<BakedItemProvider>(context, listen: false);
    await rpMdl.loadAllMeal();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => BakedItemList()),
        (r) => false);
    // Future.delayed(const Duration(seconds: 5), () {
    // });
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
              image: AssetImage("assets/images/bakedSplash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            // The Positioned widget is used to position the text inside the Stack widget
            top: 50,
            left: 65,
            width: 250,

            child: Container(
              // We use this Container to create a  box that wraps the  text
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                  ),
                  const Text(
                    'Loading...',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Please Wait',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
