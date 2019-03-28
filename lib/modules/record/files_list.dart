import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";
import 'package:uuid/uuid.dart';

import "./../../scoped_models/main.dart";

class FilesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FilesListState();
}

class _FilesListState extends State<FilesList> {
  List<Map<String, dynamic>> _files = [];

  @override
  void initState() {
    var uuid = new Uuid(); //https://pub.dartlang.org/packages/uuid

    _files = [
      {
        "id": uuid.v4(),
        "name": 'Recording number one',
        "created_at": '10:10:10 01-02-2018',
        "storage_path": '/storage/emulated/0/1231231231231232.m4a'
      },
      {
        "id": uuid.v4(),
        "name": 'Recording Second One',
        "created_at": '14:55:10 04-02-2018',
        "storage_path": '/storage/emulated/0/1231231231231232.m4a'
      },
      {
        "id": uuid.v4(),
        "name": 'Full on big recording',
        "created_at": '21:33:12 08-02-2018',
        "storage_path": '/storage/emulated/0/1231231231231232.m4a'
      },
    ];
    super.initState();
  }
  
  Widget _buildPlayButton(BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.play_circle_filled),
        onPressed: () {
//          model.selectFile(index);
//          Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (BuildContext context) {
//                  return FileEditPage();
//                },
//              )
//          ).then((_) {
//            model.deselectFile();
//          });
        }
    );
  }

  Widget _buildEditButton(BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.cloud_upload),
        onPressed: () {
//          model.selectFile(index);
//          Navigator.of(context).push(
//              MaterialPageRoute(
//                builder: (BuildContext context) {
//                  return FileEditPage();
//                },
//              )
//          ).then((_) {
//            model.deselectFile();
//          });
        }
    );
  }


  @override
  Widget build(BuildContext context) {


    return ScopedModelDescendant<MainModel>(builder: (BuildContext context, Widget child, MainModel model) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return  Column(
              children: <Widget>[
                ListTile(
//                  leading: CircleAvatar(
////                    backgroundImage: NetworkImage(model.allProducts[index].image),
//                  ),
                  title: Text(_files[index]['name']),
                  subtitle: Text(_files[index]['created_at']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _buildPlayButton(context, index, model),
                      _buildEditButton(context, index, model),
                    ],
                  ),
                ),
                Divider(),
              ],
          );
        },
        itemCount: _files.length,
      );
    });
  }
}