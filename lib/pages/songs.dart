import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import "./../models/user.dart";
import "./../scoped_models/main.dart";
import "./../modules/songs/song_list.dart";

class SongsPage extends StatefulWidget {
  final MainModel model;

  SongsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _SongsPageState();
  }
}

class _SongsPageState extends State<SongsPage> {

  @override
  void initState() {

//    print(widget.model.authUser.email);
//    print(widget.model.authUser.current_team_id);

    widget.model.fetchSongs();

    super.initState();
  }


    Widget _buildList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget content = Center(child: Text('No products found!'));
          if (model.allSongs.length > 0 && !model.isLoading) {
            content = SongList();
          } else if (model.isLoading) {
            content = Center(child: CircularProgressIndicator());
          }
          return content;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Center(
        child: _buildList(),
    );

  }
}