import "package:intl/intl.dart";
import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import "./../../models/news.dart";
import './../../scoped_models/main.dart';
import './../../widgets/ui_elements/title_default.dart';
import './../ui_elements/datetime_formats.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final int newsIndex;
  final Function deselectNews;

  NewsCard(this.news, this.newsIndex, this.deselectNews);

  Widget _buildImage() {
    return news.image_path == null
        ? Container()
        : Column(
      children: <Widget> [
        Hero(
          tag: 'newsImageHero_'+newsIndex.toString(), // Add Index to create Unique tag
          child: Image.network(news.image_path),
        ),
        SizedBox(
          height: 4.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Open up News Item');

        Navigator.pushNamed<bool>(
            context,
            '/news/' + newsIndex.toString()
        ).then((_) => deselectNews());

      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              _buildImage(),
              ListTile(
                title: Text(news.title),
                subtitle: TimeDateFormatted(news.created_at),
              ),
            ],
          )
      ),
    );

  }
}