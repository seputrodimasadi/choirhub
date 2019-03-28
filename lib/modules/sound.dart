import 'package:flutter/material.dart';
import './soundRecorder.dart';

//main class
class ModSound extends StatefulWidget {
  @override
  _ModSound createState() => new _ModSound();
}

//constructor class
class _ModSound extends State<ModSound> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new SoundRecorder(),
      ),
    );
  }
}
