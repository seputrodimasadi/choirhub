import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "./../../scoped_models/main.dart";

class NavigationDrawerWidget extends StatelessWidget {
  final BuildContext context;
  final String _currentRoute;

  NavigationDrawerWidget(this.context, this._currentRoute);

  Widget _buildDrawerHeader() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          return UserAccountsDrawerHeader(
            accountName: Text(
              model.user.name,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              model.user.email,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(model.user.photoUrl),
            ),
            decoration: BoxDecoration(
//                    color: Colors.blue,
              image: DecorationImage(
                image: ExactAssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
    );
  }

  Widget _buildChoirNameTile() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {

        String choirName = 'Your choir';
        if (model.user.currentTeamName != null) {
          choirName = model.user.currentTeamName;
        }

        return ListTile(
//          leading: CircleAvatar(
//            backgroundImage: NetworkImage(model.user.photoUrl),
//          ),
//          leading: Icon(Icons.group),
          title: Text(choirName),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            //        if (_currentRoute != '/home') {
            //          Navigator.pushReplacementNamed(context, '/home');
            //        } else {
            //          Navigator.pop(context);
            //        }
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          _buildDrawerHeader(),

          _buildChoirNameTile(),

          ListTile(
            title: Text('Home'),
            onTap: () {
              if (_currentRoute != '/home') {
                Navigator.pushReplacementNamed(context, '/home');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('News'),
            onTap: () {
              if (_currentRoute != '/news') {
                Navigator.pushReplacementNamed(context, '/news');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('Messages'),
            onTap: () {
              if (_currentRoute != '/messages') {
                Navigator.pushReplacementNamed(context, '/messages');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('Events'),
            onTap: () {
              if (_currentRoute != '/events') {
                Navigator.pushReplacementNamed(context, '/events');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('Record'),
            onTap: () {
              if (_currentRoute != '/record') {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/record');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: Text('My Profile'),
            onTap: () {
              if (_currentRoute != '/profile') {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              } else {
                Navigator.pop(context);
              }
            },
          ),

          ScopedModelDescendant(
              builder: (BuildContext context, Widget child, MainModel model) {
                return ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    model.logout();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                );
              }
          ),

        ],
      ),
    );
  }
}