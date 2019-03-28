import "dart:async";
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import './edit.dart';
import './../../models/song.dart';
import "./../../scoped_models/main.dart";



class SongSinglePage extends StatelessWidget {

  final int songIndex;

  SongSinglePage(this.songIndex);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        // Submits data on phone bak button and top arrow back button
        Navigator.pop(context, false);
        // Gets rid of error
        return Future.value(false);
      },
      child: ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
        final Song song = model.allSongs[songIndex];

        final String _shortTitle = (song.name.length >= 24) ? song.name.substring(0,24) + '...' : song.name;

        return Scaffold(
          appBar: AppBar(
            title: Text(_shortTitle),
            actions: <Widget>[
//              IconButton(
//                icon: Icon(Icons.edit),
//                onPressed: () {
//                },
//              ),
              FlatButton(
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  model.selectSong(songIndex);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SongEditPage())
                  );
                },
              )
            ],

          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
//                _buildImage(song.image_path),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0, ),
                  child: Column(
                    children: <Widget>[

                      SizedBox(
                        height: 12.0,
                      ),

                      Text(
                        song.name,
                        style: TextStyle(
                          fontSize: 36.0,
                        ),
                        textAlign: TextAlign.left,
                      ),

                      SizedBox(
                        height: 12.0,
                      ),

                      Text(
                        song.body,
                        textAlign: TextAlign.left,
                      )

                    ],
                  ),
                ),


              ],
            ),
          ),
        );
      }),
    );
  }
}