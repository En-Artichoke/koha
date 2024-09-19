import 'package:koha/features/categories/models/categories.dart';

class Article {
  final int id;
  final String title;
  final String slug;
  final String publishedAt;
  final String? excerpt;
  final String url;
  final List<Media> media;
  final Category category;

  Article({
    required this.id,
    required this.title,
    required this.slug,
    required this.publishedAt,
    this.excerpt,
    required this.url,
    required this.media,
    required this.category,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      publishedAt: json['published_at'],
      excerpt: json['excerpt'],
      url: json['url'],
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      category: Category.fromJson(json['category']),
    );
  }
}

class Media {
  final String thumb;
  final String auto;

  Media({required this.thumb, required this.auto});

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      thumb: json['thumb'],
      auto: json['auto'],
    );
  }
}
