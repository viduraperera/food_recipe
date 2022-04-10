import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String title;
  final Color color;
  final Color tColor;
  final double? font;
  final bool isLoading;

  const CustomButton(
      {Key? key,
      this.onTap,
      required this.title,
      this.color = kPurple,
      this.tColor = Colors.white,
      this.font,
      required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double r = UIManager.ratio;

    return Container(
        height: 50 * r,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: color),
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            child: this.isLoading
                ? CircularProgressIndicator()
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: font ?? 18 * r,
                        color: tColor,
                        fontWeight: FontWeight.w600),
                  ),
          ),
        ));
  }
}
