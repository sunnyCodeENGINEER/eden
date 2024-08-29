import 'package:eden/models/news_article.dart';
import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final NewsArticle article;
  const NewsTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.green[100],
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(5, 5),
            )
          ]),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  color: Color.fromARGB(255, 50, 131, 54),
                  blurRadius: 15,
                  offset: Offset(5, 5),
                ),
                const BoxShadow(
                  color: Colors.white,
                  blurRadius: 15,
                  offset: Offset(-5, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(2),
            child: article.urlToImage.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the value for the roundness
                    child: Image.network(
                      article.urlToImage,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                width: 200,
                child: Text(
                  article.title,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              SizedBox(
                height: 50,
                width: 200,
                child: Text(
                  article.description,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
