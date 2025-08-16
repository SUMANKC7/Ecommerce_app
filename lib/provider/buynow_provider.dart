import 'package:flutter/material.dart';

class BuyNowProvider extends ChangeNotifier {
  int quantity = 1;
  double deliveryCharge = 40;
  double productPrice;

  BuyNowProvider(this.productPrice);

  double get subTotal => productPrice * quantity;
  double get total => subTotal + deliveryCharge;

  void increaseQuantity() {
    quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      notifyListeners();
    }
   
  }
}
