import "package:flutter/material.dart";


import "./events_screen.dart";
import "./home_screen.dart";
import "./messages_screen.dart";


class MainScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new MainScreenState();
}


class MainScreenState extends State<MainScreen> {

  int _currentIndex = 0;

  final List<Widget> _children = [
    HomeScreen(),
    MessagesScreen(),
    EventsScreen(),
    EventsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chorus'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                //TODO: Add nav

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Messages'),
              onTap: () {
                //TODO: Add nav

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Events'),
              onTap: () {
                //TODO: Add nav

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Record'),
              onTap: () {
                //TODO: Add nav

                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('My Profile'),
              onTap: () {
                //TODO: add route

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: Colors.deepPurple,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: Text('Home'),
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
            icon: new Icon(Icons.mic),
            title: Text('Record'),
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