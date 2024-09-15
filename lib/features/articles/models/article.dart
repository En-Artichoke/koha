class Article {
  final int id;
  final int categoryId;
  final String publishedAt;
  final String title;
  final String slug;
  final String excerpt;
  final String url;
  final List<Media> media;

  Article({
    required this.id,
    required this.categoryId,
    required this.publishedAt,
    required this.title,
    required this.slug,
    required this.excerpt,
    required this.url,
    required this.media,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      categoryId: json['category_id'],
      publishedAt: json['published_at'],
      title: json['title'],
      slug: json['slug'],
      excerpt: json['excerpt'],
      url: json['url'],
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
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
