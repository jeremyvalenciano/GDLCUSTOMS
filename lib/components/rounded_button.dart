import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color btnColor;
  final double fontSize;
  final VoidCallback onPressed;

  const RoundedButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.btnColor,
      required this.fontSize,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(btnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
            side: BorderSide(color: btnColor, width: 2),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize, fontWeight: FontWeight.bold, color: textColor),
      ),
    );
  }
}
