import "dart:async";
import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import './news_edit.dart';
import './../models/news.dart';
import "./../scoped_models/main.dart";

class NewsSinglePage extends StatelessWidget {
  final int newsIndex;

  NewsSinglePage(this.newsIndex);

  Widget _buildImage(String imagePath) {
    return imagePath == null
        ? Container()
        : Column(
      children: <Widget> [
        Hero(
          tag: 'newsImageHero_'+newsIndex.toString(), // Add Index to create Unique tag
          child: Image.network(imagePath),
        ),
        SizedBox(
          height: 12.0,
        ),
      ],
    );
  }

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
        final News news = model.allNews[newsIndex];

        final String _shortTitle = (news.title.length >= 24) ? news.title.substring(0,24) + '...' : news.title;

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
                  model.selectNews(newsIndex);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewsEditPage())
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
                  _buildImage(news.image_path),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0, ),
                    child: Column(
                      children: <Widget>[

                        Text(
                          news.title,
                          style: TextStyle(
                            fontSize: 36.0,
                          ),
                          textAlign: TextAlign.left,
                        ),

                        SizedBox(
                          height: 12.0,
                        ),

                        Text(
                          news.body,
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