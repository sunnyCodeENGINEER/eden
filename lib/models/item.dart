import 'package:uuid/uuid.dart';

class Item {
  final id = const Uuid();
  final String name;
  final double price;
  final String description;
  // final String imagePath;

  Item({required this.name, required this.price, required this.description});
}
