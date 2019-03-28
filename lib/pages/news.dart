import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "./../scoped_models/main.dart";
import './../modules/news/news_list.dart';

class NewsPage extends StatefulWidget {
  final MainModel model;
  NewsPage(this.model);

  @override
  State<StatefulWidget> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  initState() {
    widget.model.fetchNews();
    super.initState();
  }

  Widget _buildList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget content = Center(child: Text('No news found!'));
          if (model.allNews.length > 0 && !model.isLoading) {
            content = NewsList();
          } else if (model.isLoading) {
            content = Center(child: CircularProgressIndicator());
          }
          return content;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}