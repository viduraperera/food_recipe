import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
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
                image: AssetImage("assets/images/main_splash.jpg"),
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
                const Text(
                  'Welcome back',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 500,
                ),
                const Text(
                  'What do you want to cook today?',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26.0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
          ],
        )

      ),

    );
  }
}
