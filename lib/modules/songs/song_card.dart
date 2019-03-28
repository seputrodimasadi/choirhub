import "package:intl/intl.dart";
import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import "./../../models/song.dart";
import './../../scoped_models/main.dart';
import './../../widgets/ui_elements/title_default.dart';
import './../ui_elements/datetime_formats.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final int songIndex;
  final Function deselectSong;

  SongCard(this.song, this.songIndex, this.deselectSong);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Open up Song Item');

        Navigator.pushNamed<bool>(
            context,
            '/songs/' + songIndex.toString()
        ).then((_) => deselectSong());

      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(song.name),
                subtitle: TimeDateFormatted(song.updated_at),
              ),
            ],
          )
      ),
    );

  }
}