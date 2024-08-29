import 'package:flutter/material.dart';
import 'package:eden/models/item.dart'; // Import the Item model

class ItemPage extends StatefulWidget {
  final Item item;
  final Function(Item) onAddToCart; // Callback to add item to cart

  const ItemPage({super.key, required this.item, required this.onAddToCart});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 186, 229, 188),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left,
              size: 40, color: Color.fromARGB(255, 45, 88, 48)),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 186, 229, 188),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // image
          Row(
            children: [
              const Spacer(),
              Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 19, 86, 21),
                        blurRadius: 15,
                        offset: Offset(5, 5),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 15,
                        offset: Offset(-5, -5),
                      )
                    ]),
              ),
              const Spacer(),
            ],
          ),
          // description
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 88, 48)),
                    ),
                    const Spacer(),
                    Text('GHs${widget.item.price}',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                Text(widget.item.description),
              ],
            ),
          ),
          const Spacer(),
          // add to cart button
          ElevatedButton(
            onPressed: () {
              widget.onAddToCart(widget.item); // Call the callback
              Navigator.pop(context); // Optionally pop the page after adding
            },
            child: const Text(
              'Add to Cart',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 88, 48)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
