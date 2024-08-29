import 'package:eden/models/item.dart'; // Import the Item model
import 'package:eden/models/shop.dart';
import 'package:flutter/material.dart';

import '../components/item_tile.dart';
import 'cart_page.dart';
import 'item_page.dart'; // Make sure to import the ItemPage

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List<Item> cart = []; // Example cart

  void _addToCart(Item item) {
    setState(() {
      cart.add(item); // Update cart with the new item
    });
  }

  void _removeFromCart(Item item) {
    setState(() {
      cart.remove(item); // Remove item from cart
    });
  }

  @override
  Widget build(BuildContext context) {
    final Shop shop = Shop();
    final items = shop.shop;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 50,
                child: Image.asset('assets/logo.png'),
              ),
              const Text(
                "Eden Shop",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 45, 88, 48)),
              ),
              const Spacer(),
              Stack(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(
                            initialCartItems:
                                cart, // Pass the cart list as initialCartItems
                            onRemoveFromCart:
                                _removeFromCart, // Pass the remove function
                          ),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_rounded,
                      color: Color.fromARGB(255, 45, 88, 48),
                      size: 35,
                    ),
                  ),
                  if (cart
                      .isNotEmpty) // Display the badge only if the cart is not empty
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Text(
                          '${cart.length}', // Display the number of items in the cart
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(
                width: 20,
              )
            ],
          ),

          // Vertical ListView.builder
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                // return ItemTile(item: item);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ItemPage(
                                item: item,
                                onAddToCart: _addToCart,
                              ) // Pass the callback),
                          ),
                    );
                  },
                  child: ItemTile(item: item),
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomAppBar(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Text('Cart: ${cart.length} items'),
      //   ),
      // ),
    );
  }
}
