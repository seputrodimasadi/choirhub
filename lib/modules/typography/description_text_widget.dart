import "package:flutter/material.dart";

class DescriptionText extends StatelessWidget {
  final String text;

  DescriptionText(this.text);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:16.0),
      child:
        Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}