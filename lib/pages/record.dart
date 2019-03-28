import "package:flutter/material.dart";

import "./../modules/navigation/drawer.dart";
import "../modules/sound2.dart";
import './../scoped_models/main.dart';

import "./../modules/record/files_list.dart";

class RecordPage extends StatelessWidget {
  final MainModel model;

  RecordPage(this.model);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
//          drawer: NavigationDrawerWidget(context, '/record'),
          appBar: AppBar(
            backgroundColor: Colors.red,
            title: Text('Record'),
            bottom: TabBar(
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(
                  text: 'New recording',
                ),
                Tab(
                  text: 'My recordings',
                ),
              ]
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ModSound(),
              FilesList(),
            ],
          ),
        )
    );
  }
}