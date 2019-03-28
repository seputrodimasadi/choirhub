import "package:flutter/material.dart";


class MessagesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('No messages set up yet...'),
            ],
          ),
        ),
    );
  }
}