// class NewsArticle {
//   final String? author;
//   final String? title;
//   final String? description;
//   final String? urlToImage;
//   final String? publishedAt;
//   final String? contents;

//   NewsArticle({
//     required this.author,
//     required this.title,
//     required this.description,
//     required this.urlToImage,
//     required this.publishedAt,
//     required this.contents,
//   });

//   factory NewsArticle.fromJson(Map<String, dynamic> json) {
//     return NewsArticle(
//       author: json['name'],
//       title: json['main']['temp'].toDouble(),
//       description: json['weather'][0]['main'],
//       urlToImage: json['weather'][0]['main'],
//       publishedAt: json['weather'][0]['main'],
//       contents: json['weather'][0]['main'],
//     );
//   }
// }

// lib/news_article.dart

class NewsArticle {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;

  NewsArticle({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      author: json['author'] ?? 'Unknown',
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      content: json['content'] ?? '',
    );
  }
}
