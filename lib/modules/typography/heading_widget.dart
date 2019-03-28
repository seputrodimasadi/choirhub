import "package:flutter/material.dart";

class TextHeading extends StatelessWidget {
  final String text;

  TextHeading(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom:16.0),
      child: RichText(
        text: TextSpan(
            text: 'Events',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 32.0,
            )),
      ),
    );
  }
}