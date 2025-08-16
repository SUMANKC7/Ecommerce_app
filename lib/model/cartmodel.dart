import 'package:ecommerce_application/model/detailproductmodel.dart';

class Cartmodel {
  final Detailproductmodel product;
  int quantity;

  Cartmodel({required this.product, this.quantity = 1});
}
