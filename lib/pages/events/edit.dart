import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import './../../models/song.dart';
import './../../models/event.dart';
import "./../../widgets/helpers/ensure-visible.dart";
import "./../../scoped_models/main.dart";

class EventEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EventEditPageState();
  }
}

class _EventEditPageState extends State<EventEditPage> {
  final Map<String, dynamic> _formData = {
    'name': '',
    'body': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _bodyFocusNode = FocusNode();

  Widget _buildNameTextField(Song song) {
    return EnsureVisibleWhenFocused(
      focusNode: _nameFocusNode,
      child: TextFormField(
        focusNode: _nameFocusNode,
        decoration: InputDecoration(
          labelText: 'Name',
        ),
        initialValue: song == null ? '' : song.name,
        validator: (String value) {
//        if(value.trim().length <= 0) {
          if(value.isEmpty) {
            return 'Please enter a name';
          }
          if(value.length < 4) {
            return 'Name must be more than 4 characters';
          }
        },
        onSaved: (String value) {
          _formData['name'] = value;
        },
      ),
    );
  }

  Widget _buildBodyTextField(Song song) {
    return EnsureVisibleWhenFocused(
      focusNode: _bodyFocusNode,
      child: TextFormField(
        focusNode: _bodyFocusNode,
        decoration: InputDecoration(
          labelText: 'Body',
        ),
        initialValue: song == null ? '' : song.body,
        maxLines: 4,
        validator: (String value) {
          if(value.isEmpty) {
            return 'Please enter a body';
          }
          if(value.length < 10) {
            return 'Body must be more than 10 characters';
          }
        },
        onSaved: (String value) {
          _formData['body'] = value;
        },
      ),
    );
  }


  Widget _buildSubmitButton() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {

          return model.isLoading
              ? Center(child: CircularProgressIndicator())
              : RaisedButton(
            child: Text('Save'),
            color: Theme.of(context).accentColor,
            textColor: Colors.white,
            onPressed: () => _submitForm(model.addSong, model.updateSong, model.deselectSong, model.selectedSongIndex),
          );
        }
    );
  }

  void _submitForm(Function addSong, Function updateSong, Function deselectSong, [int selectedSongIndex]) {
    if(!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

//    final Map<String, dynamic> product = _formData;

    if (selectedSongIndex == null) {
      addSong(
        _formData['name'],
        _formData['body'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/songs').then((_) => deselectSong()));
    } else {
      updateSong(
        _formData['name'],
        _formData['body'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/songs').then((_) => deselectSong()));
    }

  }

  Widget _buildPageContent(BuildContext context, Song song) {
//  Widget _buildPageContent(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return GestureDetector(
        onTap: () {
          print("TAP");
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
              children: <Widget>[
                _buildNameTextField(song),
                _buildBodyTextField(song),
                SizedBox(
                  height: 16.0,
                ),
                _buildSubmitButton(),
              ],
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          final Widget pageContent = _buildPageContent(context, model.selectedSong);
          return Scaffold(
            appBar: AppBar(
                title: model.selectedSongIndex == null
                    ? Text('Create Event')
                    : Text('Edit Event')
            ),
            body: pageContent,
          );
        }
    );
  }
}
