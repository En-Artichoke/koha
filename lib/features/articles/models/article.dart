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
  final List<Author> authors;

  Article({
    required this.id,
    required this.title,
    required this.slug,
    required this.publishedAt,
    this.excerpt,
    required this.url,
    required this.media,
    required this.category,
    required this.authors,
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
      authors: (json['authors'] as List<dynamic>?)
              ?.map((e) => Author.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
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

class Author {
  final int id;
  final String name;
  final String slug;
  final List<Media> media;

  Author({
    required this.id,
    required this.name,
    required this.slug,
    required this.media,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
