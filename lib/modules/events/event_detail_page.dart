import "package:flutter/material.dart";

import "../typography/description_text_widget.dart";

class EventDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Title'),
      ),
      body: SingleChildScrollView(

          child: Container(
            child: Column(
              children: <Widget>[


                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Placeholder(color: Colors.black12, fallbackHeight: 200.0,),
                ),


                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('7:00pm – 10:00pm'),
                          subtitle: Text('123 Address Street, Fremantle'),
                        ),
                        Divider(color:Colors.blue),
                        ListTile(
                          title: DescriptionText('Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                              'Nunc sit amet facilisis dui, quis lacinia nisi. Ut ultricies eros at lectus interdum lobortis. '
                              'In accumsan nisi a elit imperdiet lobortis. Phasellus sit amet tristique metus, eget blandit orci. '
                              'Cras auctor aliquam arcu, at dapibus leo tincidunt quis. Sed congue pellentesque faucibus. Lorem '
                              'ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque dui turpis, aliquam quis fermentum '
                              'id, blandit quis nunc. Mauris urna velit, viverra in semper a, vulputate vitae mauris. Curabitur nec '
                              'tempor mi, mattis ullamcorper erat. Pellentesque habitant morbi tristique senectus et netus et '
                              'malesuada fames ac turpis egestas.'),
                        ),
//                        ButtonTheme.bar( // make buttons use the appropriate styles for cards
//                          child: ButtonBar(
//                            children: <Widget>[
//                              FlatButton(
//                                child: const Text('BUY TICKETS'),
//                                onPressed: () { /* ... */ },
//                              ),
//                              FlatButton(
//                                child: const Text('LISTEN'),
//                                onPressed: () { /* ... */ },
//                              ),
//                            ],
//                          ),
//                        ),
                      ],
                    ),
                  )
                ),


                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          title: Text('going'),
                        ),
                        Chip(

                          label: Text('Not going'),
                          avatar: CircleAvatar(
                            backgroundColor: Colors.grey.shade800,
                            child: Text('AB'),
                          ),
                        ),

                        // The RSVP Section here...
                        Container(
                          padding: EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Chip(
                                    label: Text('30'),
                                  ),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  Text('Not going'),
                                ],
                              ),

                              CircleAvatar(
                                backgroundColor: Colors.grey.shade800,
                                child: Text('AB'),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),


                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(color: Colors.blue, height: 300.0,),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: '123 Address street',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      )
    );
  }
}