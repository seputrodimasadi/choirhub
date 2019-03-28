import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import "./../../models/event.dart";
import './../../scoped_models/main.dart';
import './../../widgets/ui_elements/title_default.dart';
import './../ui_elements/datetime_formats.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int eventIndex;
  final Function deselectEvent;

  EventCard(this.event, this.eventIndex, this.deselectEvent);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Open up Event Item');

        Navigator.pushNamed<bool>(
            context,
            '/events/' + eventIndex.toString()
        ).then((_) => deselectEvent());

      },
      child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(event.name),
                subtitle: Text(event.startToEnd),
              ),
            ],
          )
      ),
    );

  }
}