import "package:scoped_model/scoped_model.dart";

import './connected_model.dart';
import './events_model.dart';
import './news_model.dart';
import './songs_model.dart';
// temp scoped model, for testing and learning
import './products_model.dart';

class MainModel extends Model with ConnectedModel, UserModel, ProductsModel, NewsModel, SongsModel, EventsModel, UtilityModel {

}