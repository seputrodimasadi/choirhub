import "package:flutter/material.dart";


class FloatingRecordButton extends StatelessWidget {
  final BuildContext context;

  FloatingRecordButton(this.context);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, '/record');
      },
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      child: Icon(Icons.mic),
    );
  }
}