import 'package:uuid/uuid.dart';

class Item {
  final id = const Uuid();
  final String name;
  final double price;
  final String description;
  final String urlToImage;

  Item({required this.name, required this.price, required this.description, required this.urlToImage});
}
