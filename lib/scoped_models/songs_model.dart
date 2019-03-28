import "dart:convert";
import "dart:async";
import "package:http/http.dart" as http;

import "./connected_model.dart";
import "./../models/song.dart";

mixin SongsModel on ConnectedModel {

  String _apiUrlSongs = 'https://choirhub-staging.rmdform.com/api/songs';

  List<Song> _songs = [];
  int _selectedSongIndex;

  // Getter for the index of selected Song
  int get selectedSongIndex {
    return _selectedSongIndex;
  }

  // Getter for currently selected Song object
  Song get selectedSong {
    if(_selectedSongIndex == null) {
      return null;
    }
    return _songs[_selectedSongIndex];
  }

  // Getter for a list of all Songs
  List<Song> get allSongs {
    return List.from(_songs);
  }

  // Helper function to select the song, given it's index
  void selectSong(int songIndex) {
    _selectedSongIndex = songIndex;
    if (songIndex != null) {
      notifyListeners();
    }
  }

  // Helper function to deselect any song
  void deselectSong() {
    _selectedSongIndex = null;
    notifyListeners();
  }


  // Function to get all the Songs from the server
  void fetchSongs() {
    setLoading = true;
    notifyListeners();

    // access the API
    http.get(
      _apiUrlSongs,
      headers: {'Authorization': 'Bearer ' + authenticatedUser.token, 'Accept': 'application/json'},
    ).then((http.Response response) {

      if (response.statusCode != 200) {
        print(json.decode(response.body));
        setLoading = false;
        notifyListeners();
        return;
      }

      final List<Song> fetchedSongsList = [];

      final Map<String, dynamic> songListData = json.decode(response.body);

      if (songListData == null) {
        setLoading = false;
        notifyListeners();
        return;
      }

      if (songListData['success']) {
        songListData['data'].forEach((dynamic data) {
          final Song song = Song(
            id: data['id'],
            name: data['name'],
            body: data['body'],
            created_at: data['created_at'],
            updated_at: data['updated_at'],
            user_id: data['user_id'],
            team_id: data['team_id'],
          );
          fetchedSongsList.add(song);
        });
      }

      _songs = fetchedSongsList;

      setLoading = false;
      notifyListeners();
    });
  }


  // Function to add a new song to the server
  Future<Null> addSong(String name, String body) {
    setLoading = true;
    notifyListeners();

    final Map<String, dynamic> songData = {
      'name': name,
      'body': body,
      'user_id': authenticatedUser.id,
      'team_id': authenticatedUser.currentTeamId,
    };

    return http.post(
        _apiUrlSongs,
        headers: {
          'Authorization': 'Bearer ' + authenticatedUser.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(songData)
    ).then((http.Response response ) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      //TODO: check the status code before progressing...
      print(response.statusCode);

      if (!responseData['success']) {
        setLoading = false;
        notifyListeners();
        return;
      }

      final Song newSong = Song(
        id: responseData['data']['id'],
        name: responseData['data']['name'],
        body: responseData['data']['body'],
        created_at: responseData['data']['created_at'],
        updated_at: responseData['data']['updated_at'],
        user_id: responseData['data']['user_id'],
        team_id: responseData['data']['team_id'],
      );
      _songs.add(newSong);

      setLoading = false;
      notifyListeners();
    });
  }

  // Function to update the song
  Future<Null> updateSong(String name, String body) {
    setLoading = false;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'name': name,
      'body': body,
    };

    return http.put(
        _apiUrlSongs +'/${selectedSong.id}',
        headers: {
          'Authorization': 'Bearer ' + authenticatedUser.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(updateData)
    ).then((http.Response response) {
      setLoading = false;

      print(json.decode(response.body));

      final Song updatedSong = Song(
        id: selectedSong.id,
        name: name,
        body: body,
        created_at: selectedSong.created_at,
        updated_at: selectedSong.updated_at,
        user_id: selectedSong.user_id,
        team_id: selectedSong.team_id,
      );
      _songs[_selectedSongIndex] = updatedSong;
      notifyListeners();
    });

  }


}
