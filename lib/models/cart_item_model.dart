import 'package:adidas/models/sneaker_model.dart';

class CartItemModel {
  SneakerModel model;
  int quantity;

  CartItemModel({
    required this.model,
    required this.quantity,
  });
}
