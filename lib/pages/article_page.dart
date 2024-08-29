import 'package:flutter/material.dart';

import '../models/news_article.dart';

class ArticlePage extends StatelessWidget {
  final NewsArticle article;
  const ArticlePage({super.key, required this.article});

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

                // child: article.urlToImage.isNotEmpty
                //     ? Image.network(article.urlToImage,
                //         width: 100, fit: BoxFit.cover)
                //     : null,
                child: article.urlToImage.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Adjust the value for the roundness
                        child: Image.network(
                          article.urlToImage,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : null,
              ),
              const Spacer(),
            ],
          ),
          // description
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 45, 88, 48)),
                    ),
                    Text('By: ${article.author}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(
                  color: Color.fromARGB(255, 45, 88, 48),
                ),
                const Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 114, 162, 117)),
                ),
                Text(
                  article.description,
                  style: const TextStyle(fontSize: 18),
                ),
                const Divider(
                  color: Color.fromARGB(255, 45, 88, 48),
                ),
                const Text(
                  "Contents",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 114, 162, 117)),
                ),
                Text(
                  article.content,
                  style: const TextStyle(fontSize: 18),
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
    );
  }
}
