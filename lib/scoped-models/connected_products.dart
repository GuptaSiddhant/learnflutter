import 'package:scoped_model/scoped_model.dart';

import '../models/product.dart';
import '../models/user.dart';

mixin ConnectedProductsModel on Model {
  List<Product> _products = [];
  int _selProductIndex;

  User _authenticatedUser;

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: _authenticatedUser.email,
      userId: _authenticatedUser.id,
    );
    _products.add(newProduct);
    _selProductIndex = null;
  }
}

mixin ProductsModel on ConnectedProductsModel {
  bool _showFavourites = false;

  List<Product> get allProducts {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    return _showFavourites
        ? _products.where((Product product) => product.isFavourite).toList()
        : List.from(_products);
  }

  int get selectedProductIndex {
    return _selProductIndex;
  }

  bool get displayFavouritesOnly {
    return _showFavourites;
  }

  Product get selectedProduct {
    if (_selProductIndex == null) {
      return null;
    }
    return _products[_selProductIndex];
  }

  void updateProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userEmail: selectedProduct.userEmail,
      userId: selectedProduct.userId,
    );
    _products[_selProductIndex] = newProduct;
    // _selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selProductIndex);
    // _selProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavouriteStatus() {
    final bool isCurrentylFavourite = _products[_selProductIndex].isFavourite;
    final bool newFavouriteStatus = !isCurrentylFavourite;
    final Product updatedProduct = Product(
        title: selectedProduct.title,
        description: selectedProduct.description,
        price: selectedProduct.price,
        image: selectedProduct.image,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId,
        isFavourite: newFavouriteStatus);
    _products[_selProductIndex] = updatedProduct;
    _selProductIndex = null;

    // notifyListeners();
  }

  void selectProduct(int index) {
    _selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavourites = !_showFavourites;
    notifyListeners();
  }
}




mixin UserModel on ConnectedProductsModel {
  // User _authenticatedUser;

  void login(String email, String password) {
    _authenticatedUser = User(
      id: 'sdadasd',
      email: email,
      password: password,
    );
  }
}