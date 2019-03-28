import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import './../../scoped_models/main.dart';
import './../../models/news.dart';
import './news_card.dart';

class NewsList extends StatelessWidget {
  Widget _buildNewsList(List<News> news, Function deselectNews) {
    Widget newsCards;
    if (news.length > 0) {
      newsCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => NewsCard(news[index], index, deselectNews),
        itemCount: news.length,
      );
    }
    else {
      newsCards = Container();
    }
    return newsCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildNewsList(model.allNews, model.deselectNews);
    });
  }
}