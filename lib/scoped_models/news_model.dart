import "dart:convert";
import "dart:async";

import "package:http/http.dart" as http;
import "package:scoped_model/scoped_model.dart";

import "./connected_model.dart";
import "./../models/news.dart";

mixin NewsModel on ConnectedModel {

  String _apiUrlNews = 'https://choirhub-staging.rmdform.com/api/news';

  List<News> _news = [];

  int _selectedNewsIndex;

  int get selectedNewsIndex {
    return _selectedNewsIndex;
  }

  News get selectedNews {
    if(_selectedNewsIndex == null) {
      return null;
    }
    return _news[_selectedNewsIndex];
  }

  List<News> get allNews {
    return List.from(_news);
  }

  void selectNews(int newsIndex) {
    _selectedNewsIndex = newsIndex;
    if (newsIndex != null) {
      notifyListeners();
    }
  }

  void deselectNews() {
    _selectedNewsIndex = null;
    notifyListeners();
  }

  void fetchNews() {
    setLoading = true;
    notifyListeners();

    // access the API
    http.get(
      _apiUrlNews,
      headers: {'Authorization': 'Bearer ' + authenticatedUser.token, 'Accept': 'application/json'},
    ).then((http.Response response) {

      if (response.statusCode != 200) {
        print(json.decode(response.body));
        setLoading = false;
        notifyListeners();
        return;
      }

      final List<News> fetchedNewsList = [];

      final Map<String, dynamic> newsListData = json.decode(response.body);
      if (newsListData == null) {
        setLoading = false;
        notifyListeners();
        return;
      }

      if (newsListData['success']) {
        newsListData['data'].forEach((dynamic newsData) {
          final News news = News(
            id: newsData['id'],
            title: newsData['title'],
            body: newsData['body'],
            image_path: newsData['image_path'],
            created_at: newsData['created_at'],
          );
          fetchedNewsList.add(news);
        });
      }
      _news = fetchedNewsList;

      setLoading = false;
      notifyListeners();
    });
  }


  Future<Null> addNews(String title, String body) {
    setLoading = true;
    notifyListeners();

    final Map<String, dynamic> newsData = {
      'title': title,
      'body': body,
    };

    return http.post(
        _apiUrlNews,
        headers: {
          'Authorization': 'Bearer ' + authenticatedUser.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(newsData)
    ).then((http.Response response ) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!responseData['success']) {
        setLoading = false;
        notifyListeners();
        return;
      }

      final News newNews = News(
        id: responseData['data']['id'],
        title: responseData['data']['title'],
        body: responseData['data']['body'],
        image_path: responseData['data']['image_path'],
        created_at: responseData['data']['created_at'],
      );
      _news.add(newNews);

      setLoading = false;
      notifyListeners();
    });
  }

  Future<Null> updateNews(String title, String body) {
    setLoading = false;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'body': body,
      'image_path': selectedNews.image_path, // TODO: update this value
    };

    return http.put(
        _apiUrlNews + '/${selectedNews.id}',
        headers: {
          'Authorization': 'Bearer ' + authenticatedUser.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(updateData)
    ).then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!responseData['success']) {
        setLoading = false;
        notifyListeners();
        return;
      }

      setLoading = false;
      final News updatedNews = News(
        id: selectedNews.id,
        title: responseData['data']['title'],
        body: responseData['data']['body'],
        image_path: selectedNews.image_path,
        created_at: selectedNews.created_at,
      );
      _news[_selectedNewsIndex] = updatedNews;
      notifyListeners();
    });
  }

}
