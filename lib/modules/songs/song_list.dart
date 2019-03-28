import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import './../../scoped_models/main.dart';
import './../../models/song.dart';
import './song_card.dart';

class SongList extends StatelessWidget {
  Widget _buildSongList(List<Song> songs, Function deselectSong) {
    Widget songCards;
    if (songs.length > 0) {
      songCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => SongCard(songs[index], index, deselectSong),
        itemCount: songs.length,
      );
    }
    else {
      songCards = Container();
    }
    return songCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildSongList(model.allSongs, model.deselectSong);
    });
  }
}