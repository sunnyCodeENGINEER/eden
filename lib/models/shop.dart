import 'package:eden/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Shop extends ChangeNotifier {
  final List<Item> _shop = [
    Item(
      name: "Rake",
      price: 99.99,
      description: 'description',
    ),
    Item(
      name: "Rake",
      price: 99.99,
      description: 'description',
    ),
    Item(
      name: "Rake",
      price: 99.99,
      description: 'description',
    ),
    Item(
      name: "Rake",
      price: 99.99,
      description: 'description',
    ),
    Item(
      name: "Rake",
      price: 99.99,
      description: 'description',
    ),
    Item(
      name: "Rake",
      price: 99.99,
      description: 'description',
    ),
  ];

  // user cart
  List<Item> _cart = [];

  // get shop
  List<Item> get shop => _shop;

  // get user cart
  List<Item> get cart => _cart;

  // add item to cart
  void addCart(Item item) {
    _cart.add(item);
    notifyListeners();
  }

  // remove item from cart
  void removeFromCart(Item item) {
    _cart.remove(item);
    notifyListeners();
  }
}
