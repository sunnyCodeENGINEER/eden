import 'package:eden/components/news_tile.dart';
import 'package:eden/models/news_article.dart';
import 'package:eden/pages/article_page.dart';
import 'package:flutter/material.dart';

import '../services/news_service.dart';

// Assuming NewsArticle and NewsTile are defined elsewhere in your project
// and that ArticlePage is another widget in your project.

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsArticle> alrticles = [];
  // Define the test article
  final NewsArticle testArticle = NewsArticle(
    author: "Kojo Poet",
    title: "How to grow tomatoes.",
    description: "This article is about growing tomatoes.",
    urlToImage: "urlToImage",
    publishedAt: "publishedAt",
    content: "contents",
  );

  late Future<List<NewsArticle>> _futureNews;

  @override
  void initState() {
    super.initState();
    _futureNews = NewsService().fetchAgricultureNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Image.asset('assets/logo.png'),
              ),
              const Text(
                "Eden News",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 88, 48),
                ),
              )
            ],
          ),
        ),
      ),
      body:
          // Center(
          //   child: Column(
          //     children: [
          //       const Text(
          //         'Welcome to the News Page',
          //         style: TextStyle(
          //           fontSize: 40,
          //           color: Color.fromARGB(255, 45, 88, 48),
          //         ),
          //       ),
          //       const Text(
          //         '40',
          //         style: TextStyle(
          //           fontSize: 40,
          //           fontWeight: FontWeight.w900,
          //           color: Color.fromARGB(255, 116, 180, 120),
          //         ),
          //       ),
          //       Expanded(
          //         child: ListView.builder(
          //           itemCount: 10,
          //           itemBuilder: (context, index) {
          //             return GestureDetector(
          //               onTap: () {
          //                 Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                     builder: (context) => ArticlePage(
          //                       article: testArticle,
          //                     ),
          //                   ),
          //                 );
          //               },
          //               child: NewsTile(
          //                 article: testArticle,
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          FutureBuilder<List<NewsArticle>>(
        future: _futureNews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available'));
          } else {
            final articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticlePage(
                                article: article)) // Pass the callback),

                        );
                  },
                  child: NewsTile(
                    article: article,
                  ),
                );
                // ListTile(
                //   leading: article.urlToImage.isNotEmpty
                //       ? Image.network(article.urlToImage,
                //           width: 100, fit: BoxFit.cover)
                //       : null,
                //   title: Text(article.title),
                //   subtitle: Text(article.description),
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ArticlePage(article: article),
                //       ),
                //     );
                //   },
                // );
              },
            );
          }
        },
      ),
    );
  }
}
