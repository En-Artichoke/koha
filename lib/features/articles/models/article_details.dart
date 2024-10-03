import 'package:koha/features/most_read/model/most_read_article.dart'
    show Author, Media;

import '../../categories/models/categories.dart';

class ArticleDetails {
  final int id;
  final int statusId;
  final int categoryId;
  final String title;
  final String? subtitle;
  final String? permbledhja;
  final String text;
  final String slug;
  final Map<String, dynamic> options;
  final int viewCount;
  final String? parentId;
  final String createdAt;
  final String updatedAt;
  final String publishedAt;
  final String excerpt;
  final String url;
  final List<Author> authors;
  final List<dynamic> translators;
  final List<dynamic> editors;
  final List<Media> media;
  final Category category;
  final List<dynamic> relatedArticles;
  final List<dynamic> children;
  final dynamic parent;

  ArticleDetails({
    required this.id,
    required this.statusId,
    required this.categoryId,
    required this.title,
    this.subtitle,
    this.permbledhja,
    required this.text,
    required this.slug,
    required this.options,
    required this.viewCount,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.excerpt,
    required this.url,
    required this.authors,
    required this.translators,
    required this.editors,
    required this.media,
    required this.category,
    required this.relatedArticles,
    required this.children,
    this.parent,
  });

  factory ArticleDetails.fromJson(Map<String, dynamic> json) {
    return ArticleDetails(
      id: json['id'],
      statusId: json['status_id'],
      categoryId: json['category_id'],
      title: json['title'],
      subtitle: json['subtitle'],
      permbledhja: json['permbledhja'],
      text: json['text'],
      slug: json['slug'],
      options: json['options'],
      viewCount: json['view_count'],
      parentId: json['parent_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      publishedAt: json['published_at'],
      excerpt: json['excerpt'],
      url: json['url'],
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
      translators: json['translators'],
      editors: json['editors'],
      media: (json['media'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: Category.fromJson(json['category']),
      relatedArticles: json['related_articles'],
      children: json['children'],
      parent: json['parent'],
    );
  }
}
