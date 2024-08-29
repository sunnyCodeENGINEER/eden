import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_article.dart';

class NewsService {
  final String apiKey =
      '8984ff69471049d98848da483210b453'; // Replace with your API key
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchAgricultureNews() async {
    final response = await http
        .get(Uri.parse('$baseUrl/everything?q=agriculture&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> articlesJson = data['articles'];

      return articlesJson.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

String apiKey = '8984ff69471049d98848da483210b453';
