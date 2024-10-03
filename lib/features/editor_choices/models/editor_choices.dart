class EditorChoice {
  final int id;
  final String title;
  final String? subtitle;
  final Map<String, dynamic> options;
  final DateTime createdAt;
  final String slug;
  final int categoryId;
  final String? excerpt;
  final String url;
  final Category category;
  final List<Media> media;

  EditorChoice({
    required this.id,
    required this.title,
    this.subtitle,
    required this.options,
    required this.createdAt,
    required this.slug,
    required this.categoryId,
    this.excerpt,
    required this.url,
    required this.category,
    required this.media,
  });

  factory EditorChoice.fromJson(Map<String, dynamic> json) {
    return EditorChoice(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      options: json['options'],
      createdAt: DateTime.parse(json['created_at']),
      slug: json['slug'],
      categoryId: json['category_id'],
      excerpt: json['excerpt'],
      url: json['url'],
      category: Category.fromJson(json['category']),
      media: (json['media'] as List).map((m) => Media.fromJson(m)).toList(),
    );
  }
}

class Category {
  final int id;
  final String name;
  final String slug;
  final String? color;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      color: json['color'],
    );
  }
}

class Media {
  final int id;
  final String title;
  final String name;
  final String? caption;
  final String storagePath;
  final String mimeType;
  final String type;
  final String thumb;
  final String auto;

  Media({
    required this.id,
    required this.title,
    required this.name,
    this.caption,
    required this.storagePath,
    required this.mimeType,
    required this.type,
    required this.thumb,
    required this.auto,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      title: json['title'],
      name: json['name'],
      caption: json['caption'],
      storagePath: json['storage_path'],
      mimeType: json['mime_type'],
      type: json['type'],
      thumb: json['thumb'],
      auto: json['auto'],
    );
  }
}
