//import "dart:convert";

import "package:flutter/material.dart";
//import "package:http/http.dart" show get;

import './screens/login_screen.dart';

//class TestApp extends StatefulWidget {
//
//  @override
//  State<StatefulWidget> createState() {
//    return TestAppState();
//  }
//}
//
//
//class TestAppState extends State<TestApp> {
class TestApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Log me in',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Log me in..."),
        ),
        body: LoginScreen(),
      )
    );
  }

}