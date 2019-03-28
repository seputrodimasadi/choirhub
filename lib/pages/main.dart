import "package:flutter/material.dart";

// Import the Scoped Model
import './../scoped_models/main.dart';


// Import the Nav Widgets
import "./../modules/navigation/drawer.dart";
import './../modules/navigation/floating_record.dart';


// Import the pages
import "./news.dart";
import "./message.dart";
import "./events.dart";
import './songs.dart';
import "./home.dart";
import "./record.dart";


// Import the sub pages
import './../screens/news_edit.dart';
import './../pages/songs/edit.dart';
import './../pages/events/edit.dart';


class MainPage extends StatefulWidget {
  final MainModel model;
  final String route;

  MainPage(this.model, this.route);

  @override
  State<StatefulWidget> createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  void initState() {

    var requestedRoute = _pagesData.firstWhere((page) => page['route'] == widget.route, orElse: () => null);
    if (requestedRoute == null) {
      _currentIndex = 0;
    } else {
      _currentIndex = requestedRoute['index'];
    }

    super.initState();
  }


  final List<Map<String, dynamic>> _pagesData = [
    {
      'index': 0,
      'title': 'Choir Hub',
      'route': '/news',
    },
    {
      'index': 1,
      'title': 'Messages',
      'route': '/messages',
    },
    {
      'index': 2,
      'title': 'Events',
      'route': '/events',
    },
    {
      'index': 3,
      'title': 'Songs',
      'route': '/songs',
    }
  ];


  List<Widget> _buildActions(BuildContext context) {
    Widget _widget = Container();

    // CREATE A NEWS -- BUTTON
    if (_pagesData[_currentIndex]['route'] == '/news') {
      _widget = IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsEditPage())
          );
        },
      );
    }

    // CREATE AN EVENT -- BUTTON
    if (_pagesData[_currentIndex]['route'] == '/events') {
      _widget = IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
//          Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => EventEditPage())
//          );
        },
      );
    }

    // CREATE A SONG -- BUTTON
    if (_pagesData[_currentIndex]['route'] == '/songs') {
      _widget = IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SongEditPage())
          );
        },
      );
    }

    return <Widget>[
      _widget,
    ];
  }

  Widget _buildBody(String route) {
    Widget bodyWidget = Container();

    if (route == '/news') {
//      bodyWidget = HomePage();
      bodyWidget = NewsPage(widget.model);
    }
    if (route == '/messages') {
      bodyWidget = MessagesPage();
    }
    if (route == '/events') {
      bodyWidget = EventsPage(widget.model);
    }
    if (route == '/songs') {
      bodyWidget = SongsPage(widget.model);
    }

    return bodyWidget;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(_pagesData[_currentIndex]['title']),
          actions: _buildActions(context)
      ),
      drawer: NavigationDrawerWidget(context, '/news'),
      
      //render body
      body: _buildBody(_pagesData[_currentIndex]['route']),

      // Record floating button
      floatingActionButton: FloatingRecordButton(context),

      //bottom navs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.mail),
            title: Text('Messages'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            title: Text('Events'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.audiotrack),
            title: Text('Songs'),
          ),
        ],
      ),
    );
  }

  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}