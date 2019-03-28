import 'package:flutter/material.dart';
import "package:scoped_model/scoped_model.dart";


// Import PAGES for Routes
import './pages/record.dart';
import './screens/news.dart';
import './screens/news_single.dart';
import './screens/auth.dart';

import './pages/profile.dart';

// Import pages for Single items
import './pages/songs/single.dart';
import './pages/events/single.dart';


// Products setup
import './screens/products.dart';
import './screens/product.dart';
import './screens/products_admin.dart';
import './scoped_models/main.dart';




//import 'package:chorus_app/src/app.dart';
//import "./scoped/app.dart";
//import './screens/main_screen.dart';
//import './modules/events/event_detail_page.dart';
import './screens/auth_screen.dart';


import './pages/main.dart';

void main() => runApp(App());

class OldApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chorus App',
      home: MainPage(null, null),
    );
  }
}


class App extends StatefulWidget {
  @override
  createState() => _AppState();
}

class _AppState extends State<App> {
  final MainModel _model = MainModel();

  @override
  void initState() {
    _model.autoAuthenticate();
    //TODO: need to get the latest user info from the server on every app init load
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModel<MainModel>(
      model: _model,
      child: MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          accentColor: Colors.deepOrangeAccent,
        ),
//      home: AuthPage(),
        routes: {
          '/': (BuildContext context) =>  ScopedModelDescendant(
            builder: (BuildContext context, Widget child, MainModel model) {
              return model.user == null ? AuthPage() : MainPage(_model, '/news');
            },
          ),
          // DEMO ROUTES
            '/products': (BuildContext context) => ProductsPage(_model),
            '/admin': (BuildContext context) => ProductsAdminPage(_model),
          // END DEMO ROUTES
          '/home': (BuildContext context) => MainPage(_model, '/home'),
          '/news': (BuildContext context) => MainPage(_model, '/news'),
//          '/news': (BuildContext context) => NewsScreen(_model),
          '/messages': (BuildContext context) => MainPage(_model, '/messages'),
          '/events': (BuildContext context) => MainPage(_model, '/events'),
          '/songs': (BuildContext context) => MainPage(_model, '/songs'),
          '/record': (BuildContext context) => RecordPage(_model),
          '/profile': (BuildContext context) => ProfilePage(_model),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') {
            // RouteName must start with a /, if it does not, then return null // Invalid Route
            return null;
          }

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]); // Get the ID from the Route, and convert in to an Integer
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductPage(index),
            );
          }

          if (pathElements[1] == 'news') {
            final int index = int.parse(pathElements[2]); // Get the ID from the Route, and convert in to an Integer
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  NewsSinglePage(index),
            );
          }

          if (pathElements[1] == 'songs') {
            final int index = int.parse(pathElements[2]); // Get the ID from the Route, and convert in to an Integer
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  SongSinglePage(index),
            );
          }

          if (pathElements[1] == 'events') {
            final int index = int.parse(pathElements[2]); // Get the ID from the Route, and convert in to an Integer
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  EventSinglePage(index),
            );
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          //This will trigger if null route is returned
          return MaterialPageRoute(
            builder: (BuildContext context) => NewsScreen(_model),
          );
        },
      ),
    );
  }
}


