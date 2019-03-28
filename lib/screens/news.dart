import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import "./../modules/navigation/drawer.dart";
import './../modules/navigation/floating_record.dart';
import "./../scoped_models/main.dart";
import './../widgets/ui_elements/logout_list_tile.dart';
import './../modules/news/news_list.dart';
import './news_edit.dart';


class NewsScreen extends StatefulWidget {
  final MainModel model;

  NewsScreen(this.model);

  @override
  State<StatefulWidget> createState() => NewsScreenState();
}

class NewsScreenState extends State<NewsScreen> {
  @override
  initState() {
    widget.model.fetchNews();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('News'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/news');
            },
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          ),
          Divider(),
          LogoutListTile(),
        ],
      ),
    );
  }

  Widget _buildNewsList() {

    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget content = Center(child: Text('No products found!'));
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
    return Scaffold(
      drawer: NavigationDrawerWidget(context, '/news'),
      floatingActionButton: FloatingRecordButton(context),
      appBar: AppBar(
        title: Text('News'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsEditPage())
              );
            },
          ),
//          FlatButton(
//            child: Text('New'),
//            onPressed: () {
//
//            },
//          )
        ],
      ),
      body: _buildNewsList(),

//      bottomNavigationBar: NavigationTabs(),


    );
  }
}