import 'package:ecommerce_application/model/cartmodel.dart';
import 'package:ecommerce_application/model/detailproductmodel.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Cartmodel> _items = [];

  List<Cartmodel> get items => _items;

  void add(Detailproductmodel product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(Cartmodel(product: product));
    }
    notifyListeners();
  }

  void remove(int productid) {
    _items.removeWhere((item) => item.product.id == productid);
    notifyListeners();
  }

  void decreaseQuantity(int productId) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == productId,
    );

    if (existingIndex >= 0) {
      if (_items[existingIndex].quantity > 1) {
        _items[existingIndex].quantity--;
      } else {
        _items.removeAt(existingIndex);
      }
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  double get totalAmt {
    return _items.fold(
      0.0,
      (sum, item) => sum + (item.product.productPrice ?? 0.0) * item.quantity,
    );
  }
}
