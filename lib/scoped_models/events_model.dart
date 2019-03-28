import "dart:convert";
import "dart:async";
import "package:http/http.dart" as http;

import "./connected_model.dart";
import "./../models/event.dart";

mixin EventsModel on ConnectedModel {

  String _apiUrlEvents = 'https://choirhub-staging.rmdform.com/api/events';

  List<Event> _events = [];
  int _selectedEventIndex;

  // Getter for the index of selected Event
  int get selectedEventIndex {
    return _selectedEventIndex;
  }

  // Getter for currently selected Event object
  Event get selectedEvent {
    if(_selectedEventIndex == null) {
      return null;
    }
    return _events[_selectedEventIndex];
  }

  // Getter for a list of all Events
  List<Event> get allEvents {
    return List.from(_events);
  }

  // Helper function to select the event, given it's index
  void selectEvent(int index) {
    _selectedEventIndex = index;
    if (index != null) {
      notifyListeners();
    }
  }

  // Helper function to deselect any event
  void deselectEvent() {
    _selectedEventIndex = null;
    notifyListeners();
  }


  // Function to get all the Events from the server
  void fetchEvents() {
    setLoading = true;
    notifyListeners();

    // access the API
    http.get(
      _apiUrlEvents,
      headers: {'Authorization': 'Bearer ' + authenticatedUser.token, 'Accept': 'application/json'},
    ).then((http.Response response) {

      if (response.statusCode != 200) {
        print(json.decode(response.body));
        setLoading = false;
        notifyListeners();
        return;
      }

      final List<Event> fetchedEventsList = [];

      final Map<String, dynamic> eventListData = json.decode(response.body);

      if (eventListData == null) {
        setLoading = false;
        notifyListeners();
        return;
      }

      if (eventListData['success']) {
        eventListData['data'].forEach((dynamic data) {
          final Event event = Event(
            userId: data['user_id'],
            teamId: data['team_id'],
            createdAt: data['created_at'],
            updatedAt: data['updated_at'],
            id: data['id'],
            name: data['name'],
            body: data['body'],

            startAt: data['start_at'],
            endAt: data['end_at'],
            startToEnd: data['start_to_end'],

            address: data['address'],
            suburb: data['suburb'],
            postcode: data['postcode'],
            state: data['state'],
            country: data['country'],
          );
          fetchedEventsList.add(event);
        });
      }

      _events = fetchedEventsList;

      print(_events);

      setLoading = false;
      notifyListeners();
    });
  }


  // Function to add a new Event to the server
  Future<Null> addEvent(String name, String body) {
    setLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'name': name,
      'body': body,
//      'userEmail': _authenticatedUser.email,
//      'userId': _authenticatedUser.id
      'user_id': authenticatedUser.id,
      'team_id': authenticatedUser.currentTeamId,
    };

    return http.post(
        _apiUrlEvents,
        headers: {
          'Authorization': 'Bearer ' + authenticatedUser.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(formData)
    ).then((http.Response response ) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!responseData['success']) {
        setLoading = false;
        notifyListeners();
        return;
      }

      final Event newEvent = Event(
        userId: responseData['data']['user_id'],
        teamId: responseData['data']['team_id'],
        createdAt: responseData['data']['created_at'],
        updatedAt: responseData['data']['updated_at'],
        id: responseData['data']['id'],
        name: responseData['data']['name'],
        body: responseData['data']['body'],

        startAt: responseData['start_at'],
        endAt: responseData['end_at'],
        startToEnd: responseData['start_to_end'],

        address: responseData['address'],
        suburb: responseData['suburb'],
        postcode: responseData['postcode'],
        state: responseData['state'],
        country: responseData['country'],
      );
      _events.add(newEvent);

      setLoading = false;
      notifyListeners();
    });
  }

  // Function to update the Event
  Future<Null> updateEvent(String name, String body) {
    setLoading = false;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'name': name,
      'body': body,
    };

    return http.put(
        _apiUrlEvents +'/${selectedEvent.id}',
        headers: {
          'Authorization': 'Bearer ' + authenticatedUser.token,
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode(updateData)
    ).then((http.Response response) {
      setLoading = false;

      Map<String, dynamic> data = json.decode(response.body);

      final Event updatedEvent = Event(
        userId: selectedEvent.userId,
        teamId: selectedEvent.teamId,
        createdAt: selectedEvent.createdAt,
        updatedAt: data['data']['updated_at'],
        id: selectedEvent.id,

        name: data['data']['name'],
        body: data['data']['body'],

        startAt: data['start_at'],
        endAt: data['end_at'],
        startToEnd: data['start_to_end'],

        address: data['address'],
        suburb: data['suburb'],
        postcode: data['postcode'],
        state: data['state'],
        country: data['country'],
      );
      _events[_selectedEventIndex] = updatedEvent;
      notifyListeners();
    });

  }


}
