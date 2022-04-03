import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/index.dart';


class InputField extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? initialValue;
  final String? prefixText;
  final String? Function(String?)? validator;
  final TextInputType? type;
  final bool obscureText;
  final String? hint;
  final Widget? suffix;
  final TextEditingController? controller;
  final TextStyle? hintStyle;
  final ValueChanged<String>? onSubmit;
  final String? label;
  final bool isMulti;
  final int? maxLength;

  const InputField(
      {Key? key,
        this.onChanged,
        this.onSaved,
        this.initialValue = "",
        this.validator,
        this.type,
        this.obscureText = false,
        this.hint,
        this.suffix,
        this.controller,
        this.prefixText,
        this.onSubmit,
        this.hintStyle = const TextStyle(color: Colors.grey, fontSize: 15),
        this.label,
        this.isMulti = false,
        this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double r = UIManager.ratio;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        label != null
            ? Text(
          label!,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18 * r,
              fontWeight: FontWeight.bold),
        )
            : Container(),
        Container(
            margin: EdgeInsets.only(bottom: 6.0 * r, top: 10.0 * r),
            child: TextFormField(
              onFieldSubmitted: onSubmit,
              maxLines: isMulti ? null : 1,
              maxLength: maxLength,
              // initialValue: initialValue ?? "",
              controller: controller,
              onChanged: onChanged,
              validator: validator,
              onSaved: onSaved,
              keyboardType: type,
              obscureText: obscureText,
              decoration: InputDecoration(
                suffixIcon: suffix,
                isDense: true,
                hintText: hint ?? "",
                hintStyle: hintStyle,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kGrey, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kGrey, width: 1.0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kRed, width: 1.0),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: kRed, width: 1.0),
                ),
              ),
            )),
      ],
    );
  }
}
