import '../../editor_choices/models/editor_choices.dart';

class LatestCategoryArticle {
  final int id;
  final String title;
  final String? subtitle;
  final Map<String, dynamic> options;
  final DateTime publishedAt;
  final String slug;
  final int categoryId;
  final String? excerpt;
  final String url;
  final Category category;
  final List<Media> media;

  LatestCategoryArticle({
    required this.id,
    required this.title,
    this.subtitle,
    required this.options,
    required this.publishedAt,
    required this.slug,
    required this.categoryId,
    this.excerpt,
    required this.url,
    required this.category,
    required this.media,
  });

  factory LatestCategoryArticle.fromJson(Map<String, dynamic> json) {
    return LatestCategoryArticle(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      options: json['options'] ?? {},
      publishedAt: DateTime.parse(json['published_at']),
      slug: json['slug'],
      categoryId: json['category_id'],
      excerpt: json['excerpt'],
      url: json['url'],
      category: Category.fromJson(json['category']),
      media: (json['media'] as List?)?.map((m) => Media.fromJson(m)).toList() ??
          [],
    );
  }
}
