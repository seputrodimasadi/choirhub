import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import './../../scoped_models/main.dart';
import './../../models/event.dart';
import './event_card.dart';

class EventList extends StatelessWidget {
  Widget _buildEventList(List<Event> events, Function deselectEvent) {
    Widget eventCards;
    if (events.length > 0) {
      eventCards = ListView.builder(
        itemBuilder: (BuildContext context, int index) => EventCard(events[index], index, deselectEvent),
        itemCount: events.length,
      );
    }
    else {
      eventCards = Container();
    }
    return eventCards;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return _buildEventList(model.allEvents, model.deselectEvent);
    });
  }
}