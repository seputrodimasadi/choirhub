import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import "./../scoped_models/main.dart";
import './../modules/events/event_list.dart';

class EventsPage extends StatefulWidget {
  final MainModel model;
  EventsPage(this.model);

  @override
  State<StatefulWidget> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  initState() {
    widget.model.fetchEvents();
    super.initState();
  }

  Widget _buildList() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
          Widget content = Center(child: Text('No events found!'));
          if (model.allEvents.length > 0 && !model.isLoading) {
            content = EventList();
          } else if (model.isLoading) {
            content = Center(child: CircularProgressIndicator());
          }
          return content;
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}