import 'package:eden/models/item.dart';
import 'package:flutter/material.dart';

class Shop extends ChangeNotifier {
  final List<Item> _shop = [
    Item(
      name: "Hoe",
      price: 29.99,
      description:
          'A hoe is a versatile garden tool used for digging, cultivating, and weeding soil. It features a long handle with a flat, angled blade attached to the end. The blade can be pushed or pulled through the soil to break up clumps, remove weeds, and prepare planting beds.',
      urlToImage: 'assets/hoe.jpeg', // Path to image
    ),
    Item(
      name: "Shovel",
      price: 39.99,
      description:
          'A shovel is a hand tool used for digging, lifting, and moving materials such as soil, sand, or snow. It consists of a long handle and a broad, flat blade. The blade is usually made of metal and is designed to scoop and transport materials efficiently.',
      urlToImage: 'assets/shovel.jpeg', // Path to image
    ),
    Item(
      name: "Tiller",
      price: 499.99,
      description:
          'A tiller is a motorized tool used for breaking up and preparing soil for planting. It features rotating blades or tines that dig into the soil, turning and aerating it to create a fine seedbed. Tillers can be either front-tine or rear-tine, depending on the placement of the blades.',
      urlToImage: 'assets/tiller.jpeg', // Path to image
    ),
    Item(
      name: "Garden Fork",
      price: 24.99,
      description:
          'A garden fork is a tool used for turning and aerating soil, as well as for lifting and moving materials like compost. It has a handle and several long, pointed tines that penetrate the soil, making it easier to loosen and mix the soil without disturbing its structure.',
      urlToImage: 'assets/garden fork.jpeg', // Path to image
    ),
    Item(
      name: "Pruning Shears",
      price: 15.99,
      description:
          'Pruning shears, also known as secateurs, are hand tools used for cutting and trimming plants, shrubs, and small branches. They feature two sharp, curved blades that create a clean cut and are essential for maintaining healthy plants and shaping garden foliage.',
      urlToImage: 'assets/pruning shears.jpeg', // Path to image
    ),
    Item(
      name: "Rake",
      price: 99.99,
      description:
          'A rake is a common gardening tool used for gathering leaves, grass, or other debris, as well as for leveling and smoothing soil. It typically consists of a long handle with a row of teeth or tines attached to a head.',
      urlToImage: 'assets/rake.jpeg', // Path to image
    ),
    Item(
      name: "Plows",
      price: 15999.99,
      description:
          'Plows are used to turn over the soil and prepare it for planting. They are typically attached to tractors and come in different types, including moldboard plows, chisel plows, and disc plows. Moldboard plows are the most common type of plow and are used to create furrows in the soil, while chisel plows are used to loosen compacted soil. Disc plows are used for soil preparation in rocky or hard soil conditions.',
      urlToImage: 'assets/plow.jpeg', // Path to image
    ),
    Item(
      name: "Cultivators",
      price: 8999.99,
      description:
          'Cultivators are used to breaking up clumps of soil and remove weeds from the fields. They are typically attached to tractors and come in different types, including field cultivators and row cultivators. Field cultivators are used for large fields, while row cultivators are used for smaller plots of land.',
      urlToImage: 'assets/cultivator.jpeg', // Path to image
    ),
    Item(
      name: "Planters",
      price: 7899.99,
      description:
          'Planters are used to plant crops such as corn, soybeans, and cotton. They are equipped with seed hoppers and planting mechanisms that deposit seeds into the soil at a consistent depth and spacing. Some planters are also equipped with fertilizer systems that can add fertilizer to the soil as the seeds are being planted.',
      urlToImage: 'assets/planter.jpeg', // Path to image
    ),
    Item(
      name: "Sprayers",
      price: 299.99,
      description:
          'Sprayers are used to apply pesticides, herbicides, and fertilizers to crops. They come in different types, including boom sprayers, backpack sprayers, and air blast sprayers. Boom sprayers are the most common type of sprayer and are used for large fields, while backpack sprayers are used for smaller plots of land. Air blast sprayers are used for...',
      urlToImage: 'assets/sprayer.jpeg', // Path to image
    ),
    Item(
      name: "Loaders",
      price: 10999.99,
      description:
          'Loaders are used for various tasks, including loading and unloading crops, moving hay bales, and clearing debris from fields. They are typically attached to tractors and come in different types, including front-end loaders and backhoes. Front-end loaders are used for loading and unloading crops, while backhoes are used for digging and excavation tasks.',
      urlToImage: 'assets/loader.jpeg', // Path to image
    ),
    Item(
      name: "Balers",
      price: 18999.99,
      description:
          'Balers are used to bale hay and straw for livestock feed. They come in different types, including round balers and square balers. Round balers are used for making cylindrical bales of hay, while square balers are used for making rectangular bales of hay or straw.',
      urlToImage: 'assets/baler.jpeg', // Path to image
    ),
    Item(
      name: "Mowers",
      price: 785.99,
      description:
          'A mower is a machine used for cutting grass, weeds, or other vegetation to maintain a lawn or a playing field. There are various types of mowers including push mowers, riding mowers, and robotic mowers. The choice of a mower depends on the size of the area to be mowed and personal preferences. Mowers can be powered by gasoline, electricity, or battery, and some are designed for residential use while others are suitable for commercial use. Proper maintenance of mowers, including regular oil changes and blade sharpening, can help to extend their lifespan and ensure efficient operation.',
      urlToImage: 'assets/mower.jpeg', // Path to image
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
