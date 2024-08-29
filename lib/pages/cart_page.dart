import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../models/item.dart'; // For copying to clipboard

class CartPage extends StatefulWidget {
  final List<Item> initialCartItems;
  final Function(Item) onRemoveFromCart;

  CartPage({required this.initialCartItems, required this.onRemoveFromCart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List<Item> cartItems;
  final Uuid uuid = const Uuid();

  @override
  void initState() {
    super.initState();
    cartItems = widget.initialCartItems;
  }

  void _removeItem(Item item) {
    setState(() {
      cartItems.remove(item);
    });
    widget.onRemoveFromCart(item);
  }

  double _calculateTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  void _orderItems() {
    if (cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          backgroundColor: Color.fromARGB(255, 45, 88, 48),
        ),
      );
      return;
    }

    // Generate a unique ticket ID
    String ticketId = uuid.v4();

    // Clear the cart
    // setState(() {
    //   cartItems.clear();
    // });

    setState(() {
      while (cartItems.isNotEmpty) {
        _removeItem(cartItems[0]);
      }
    });

    // Show a dialog with the ticket ID
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Order Placed!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your Ticket ID: $ticketId'),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: ticketId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Ticket ID copied to clipboard'),
                      backgroundColor: Color.fromARGB(255, 45, 88, 48),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.copy,
                  color: Color.fromARGB(255, 45, 88, 48),
                ),
                label: const Text(
                  'Copy Ticket ID',
                  style: TextStyle(
                    color: Color.fromARGB(255, 45, 88, 48),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Color.fromARGB(255, 45, 88, 48),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = _calculateTotalPrice();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 40,
            color: Color.fromARGB(255, 45, 88, 48),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              const Text(
                "Cart",
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 45, 88, 48)),
              ),
              const Spacer(),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        while (cartItems.isNotEmpty) {
                          _removeItem(cartItems[0]);
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.delete_sweep_sharp,
                      size: 40,
                      color: Colors.red,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Dismissible(
                  key: Key(item.id.toString()),
                  onDismissed: (direction) {
                    _removeItem(item);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${item.name} removed from cart'),
                        backgroundColor: const Color.fromARGB(255, 45, 88, 48),
                      ),
                    );
                  },
                  background: Container(color: Colors.red),
                  child: ListTile(
                    title: Text(item.name),
                    subtitle: Text('Price: ${item.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(item);
                      },
                    ),
                  ),
                );
              },
            ),
      // floatingActionButton: _CustomFloatingActionButton(
      //   onPressed: _orderItems, // Pass the order function to the custom button
      // ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
            left: 30.0), // Adjust this value to position the button and text
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: GHs${totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            _CustomFloatingActionButton(
              onPressed:
                  _orderItems, // Pass the order function to the custom button
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CustomFloatingActionButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_checkout, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Order Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
