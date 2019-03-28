import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import './../models/news.dart';
import "./../widgets/helpers/ensure-visible.dart";
import "./../scoped_models/main.dart";

class NewsEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsEditPageState();
  }
}

class _NewsEditPageState extends State<NewsEditPage> {
  final Map<String, dynamic> _formData = {
    'title': '',
    'body': '',
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _bodyFocusNode = FocusNode();

  Widget _buildTitleTextField(News news) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          labelText: 'Title',
        ),
        initialValue: news == null ? '' : news.title,
        validator: (String value) {
//        if(value.trim().length <= 0) {
          if(value.isEmpty) {
            return 'Please enter a title';
          }
          if(value.length < 4) {
            return 'Title must be more than 4 characters';
          }
        },
        onSaved: (String value) {
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _buildBodyTextField(News news) {
    return EnsureVisibleWhenFocused(
      focusNode: _bodyFocusNode,
      child: TextFormField(
        focusNode: _bodyFocusNode,
        decoration: InputDecoration(
          labelText: 'Body',
        ),
        initialValue: news == null ? '' : news.body,
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
            onPressed: () => _submitForm(model.addNews, model.updateNews, model.deselectNews, model.selectedNewsIndex),
          );
        }
    );
  }

  void _submitForm(Function addNews, Function updateNews, Function deselectNews, [int selectedNewsIndex]) {
    if(!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

//    final Map<String, dynamic> product = _formData;

    if (selectedNewsIndex == null) {
      addNews(
        _formData['title'],
        _formData['body'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/news').then((_) => deselectNews()));
    } else {
      updateNews(
        _formData['title'],
        _formData['body'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/news').then((_) => deselectNews()));
    }

  }

  Widget _buildPageContent(BuildContext context, News news) {
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
                _buildTitleTextField(news),
                _buildBodyTextField(news),
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
          final Widget pageContent = _buildPageContent(context, model.selectedNews);
          return Scaffold(
            appBar: AppBar(
                title: model.selectedNewsIndex == null
                    ? Text('Create News')
                    : Text('Edit News')
            ),
            body: pageContent,
          );
        }
    );
  }

}

