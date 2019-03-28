import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import './../models/product.dart';
import "./../widgets/helpers/ensure-visible.dart";
import "./../scoped_models/main.dart";

class ProductEditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage> {
  final Map<String, dynamic> _formData = {
    'title': '',
    'description': '',
    'price': 0.0,
    'image': 'assets/dog.jpg'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  Widget _buildTitleTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _titleFocusNode,
      child: TextFormField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          labelText: 'Title',
        ),
        initialValue: product == null ? '' : product.title,
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

  Widget _buildDescriptionTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _descriptionFocusNode,
      child: TextFormField(
        focusNode: _descriptionFocusNode,
        decoration: InputDecoration(
          labelText: 'Description',
        ),
        initialValue: product == null ? '' : product.description,
        maxLines: 4,
        validator: (String value) {
          if(value.isEmpty) {
            return 'Please enter a description';
          }
          if(value.length < 10) {
            return 'Title must be more than 10 characters';
          }
        },
        onSaved: (String value) {
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _buildPriceTextField(Product product) {
    return EnsureVisibleWhenFocused(
      focusNode: _priceFocusNode,
      child: TextFormField(
        focusNode: _priceFocusNode,
        decoration: InputDecoration(
            labelText: 'Price'
        ),
        initialValue: product == null ? '' : product.price.toString(),
        keyboardType: TextInputType.number,
        validator: (String value) {
  //        if(value.trim().length <= 0) {
          if(value.isEmpty) {
            return 'Please enter a price';
          }
  //        if(!RegExp(r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$').hasMatch(value)) {
          if(!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
            return 'Price must be a number';
          }
        },
        onSaved: (String value) {
          _formData['price'] = double.parse(value);
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
          onPressed: () => _submitForm(model.addProduct, model.updateProduct, model.deselectProduct, model.selectedProductIndex),
        );
      }
    );
  }

  void _submitForm(Function addProduct, Function updateProduct, Function deselectProduct, [int selectedProductIndex]) {
    if(!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
//    final Map<String, dynamic> product = _formData;
    if (selectedProductIndex == null) {
      addProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products').then((_) => deselectProduct()));
    } else {
      updateProduct(
        _formData['title'],
        _formData['description'],
        _formData['image'],
        _formData['price'],
      ).then((_) => Navigator.pushReplacementNamed(context, '/products').then((_) => deselectProduct()));
    }

  }

  Widget _buildPageContent(BuildContext context, Product product) {
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
                _buildTitleTextField(product),
                _buildDescriptionTextField(product),
                _buildPriceTextField(product),
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
        final Widget pageContent = _buildPageContent(context, model.selectedProduct);
        return model.selectedProductIndex == null
          ? pageContent
          : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product')
            ),
            body: pageContent,
          );
      }
    );
  }

}

