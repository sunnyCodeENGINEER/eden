import 'package:eden/models/item.dart'; // Import the Item model
import 'package:flutter/material.dart';

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
                padding: const EdgeInsets.all(5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20), // Adjust the value for the roundness
                  child: Image.asset(
                    widget.item.urlToImage,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.name,
                      style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 88, 48)),
                    ),
                    Row(
                      children: [
                        const Spacer(),
                        Text('GHs${widget.item.price}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.item.description,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // add to cart button
          // ElevatedButton(
          //   onPressed: () {
          //     widget.onAddToCart(widget.item); // Call the callback
          //     Navigator.pop(context); // Optionally pop the page after adding
          //   },
          //   child: const Text(
          //     'Add to Cart',
          //     style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //         color: Color.fromARGB(255, 45, 88, 48)),
          //   ),
          // ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 30),
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
          // const Spacer()
        ],
      ),
    );
  }
}
