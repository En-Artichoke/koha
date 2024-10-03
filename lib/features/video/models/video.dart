class Video {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  final String categoryName;
  final DateTime createdAt;
  final Map<String, dynamic> options;
  final String slug;
  final int categoryId;
  final String? excerpt;

  Video({
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    required this.categoryName,
    required this.createdAt,
    required this.options,
    required this.slug,
    required this.categoryId,
    this.excerpt,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] as int,
      title: json['title'] as String,
      url: json['options']['video'] as String,
      thumbnailUrl: json['media'][0]['auto'] as String,
      categoryName: json['category']['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      options: json['options'] as Map<String, dynamic>,
      slug: json['slug'] as String,
      categoryId: json['category_id'] as int,
      excerpt: json['excerpt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'options': {
        ...options,
        'video': url,
      },
      'media': [
        {
          'auto': thumbnailUrl,
        }
      ],
      'category': {
        'name': categoryName,
      },
      'created_at': createdAt.toIso8601String(),
      'slug': slug,
      'category_id': categoryId,
      'excerpt': excerpt,
    };
  }

  @override
  String toString() {
    return 'Video(id: $id, title: $title, url: $url, thumbnailUrl: $thumbnailUrl, categoryName: $categoryName, createdAt: $createdAt)';
  }
}
