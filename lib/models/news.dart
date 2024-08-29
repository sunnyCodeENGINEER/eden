import 'dart:convert';

import 'package:eden/models/news_article.dart';
import 'package:eden/services/news_service.dart';
import 'package:http/http.dart' as http;

class News {
  List<NewsArticle> news = [];

  Future<void> getNews() async {
    String url =
        'https://newsapi.org/v2/everything?q=Apple&from=2024-08-29&sortBy=popularity&apiKey=${apiKey}';
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          NewsArticle articleModel = NewsArticle(
              author: element['author'],
              title: element['title'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: element['publishedAt'],
              content: element['content']);
          news.add(articleModel);
        }
      });
    }
  }
}
