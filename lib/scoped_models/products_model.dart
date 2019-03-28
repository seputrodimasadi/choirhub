import "dart:convert";
import "dart:async";

import "package:http/http.dart" as http;
import 'package:uuid/uuid.dart';

import "./connected_model.dart";
import "./../models/product.dart";


mixin ProductsModel on ConnectedModel {
  List<Product> _products = [];
  int _selectedProductIndex;
  String _selectedProductId;

  bool _showFavourites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavourites) {
      return _products.where((Product product) => product.isFavourite).toList();
    }
    return List.from(_products);
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  int get selectedProductIndex {
    return _selectedProductIndex;
  }

  String get selectedProductId {
    return _selectedProductId;
  }

  Product get selectedProduct {
    if(_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }



  Future<Null> addProduct(String title, String description, String image, double price) {
    var uuid = new Uuid(); //https://pub.dartlang.org/packages/uuid
    setLoading = true;
    notifyListeners();

    final Map<String, dynamic> productData = {
      'title': title,
      'description': description,
      'image': 'https://loremflickr.com/cache/resized/4868_32786042658_275cb41d53_z_640_360_nofilter.jpg',
      'price': price,
      'userEmail': authenticatedUser.email,
      'userId': authenticatedUser.id
    };

    // Send the data to Firebase
    return http.post(
        'https://chorus-app-demo.firebaseio.com/products.json',
        body: json.encode(productData)
    ).then((http.Response response ) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final Product newProduct = Product(
          id: responseData['name'],
          title: title,
          description: description,
          image: image,
          price: price,
          userEmail: authenticatedUser.email,
          userId: authenticatedUser.id
      );
      _products.add(newProduct);

      setLoading = false;
      notifyListeners();
    });
  }



  Future<Null> updateProduct(String title, String description, String image, double price) {
    setLoading = false;
    notifyListeners();

    final Map<String, dynamic> updateData = {
      'title': title,
      'description': description,
      'image': selectedProduct.image, // TODO: update this value
      'price': price,
      'userEmail': selectedProduct.userEmail,
      'userId': selectedProduct.userId,
    };

    return http.put('https://chorus-app-demo.firebaseio.com/products/${selectedProduct.id}.json', body: json.encode(updateData))
        .then((http.Response response) {
      setLoading = false;

      final Product updatedProduct = Product(
        id: selectedProduct.id,
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
      );
      _products[_selectedProductIndex] = updatedProduct;
      notifyListeners();
    });

  }

  void deleteProduct() {
    setLoading = true;
    final deletedProductId = selectedProduct.id;
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
    notifyListeners();

    http.delete('https://chorus-app-demo.firebaseio.com/products/${deletedProductId}.json')
        .then((response) {
      setLoading = false;
      notifyListeners();
    });
  }

  void fetchProducts() {
    setLoading = true;
    notifyListeners();

    // access the API
    http.get('https://chorus-app-demo.firebaseio.com/products.json')
        .then((http.Response response) {

      final List<Product> fetchedProductList = [];

      final Map<String, dynamic> productListData = json.decode(response.body);

      if (productListData == null) {
        setLoading = false;
        notifyListeners();
        return;
      }

      productListData.forEach((String productId, dynamic productData) {
        final Product product = Product(
          id: productId,
          title: productData['title'],
          description: productData['description'],
          image: productData['image'],
          price: productData['price'],
          userId: productData['userId'],
          userEmail: productData['userEmail'],
        );
        fetchedProductList.add(product);
      });

      _products = fetchedProductList;

      setLoading = false;
      notifyListeners();
    });



  }

  void toggleProductFavouriteStatus() {
    final bool isCurrentlyFavourite = selectedProduct.isFavourite;
    final bool newFavouriteStatus = !isCurrentlyFavourite;
    final Product updatedProduct = Product(
      id: selectedProduct.id,
      title: selectedProduct.title,
      description: selectedProduct.description,
      price: selectedProduct.price,
      image: selectedProduct.image,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
      isFavourite: newFavouriteStatus,
    );
    _products[_selectedProductIndex] = updatedProduct;
    notifyListeners();
  }

  void selectProduct(int productIndex) {
    _selectedProductIndex = productIndex;
    if (productIndex != null) {
      notifyListeners();
    }
  }

  void deselectProduct() {
    _selectedProductId = null;
    _selectedProductIndex = null;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }

}
