import 'package:flutter/cupertino.dart';

class ResponsiveProvider extends StatelessWidget {
  final Widget child;

  const ResponsiveProvider({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UIManager.initialize(context);
    return child;
  }
}

class UIManager {
  static double height = 0;
  static double ratio = 1;

  static void initialize(context) {
    height = MediaQuery.of(context).size.height;

    if (height <= 600) {
      ratio = .75;
    }
    if (height > 600 && height <= 800) {
      ratio = .9;
    }
    if (height > 800) {
      ratio = 1;
    }
  }
}