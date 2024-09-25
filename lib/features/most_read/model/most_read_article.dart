class MostReadArticle {
  final int id;
  final String title;
  final String slug;
  final int categoryId;
  final String? excerpt;
  final String url;
  final Category category;
  final List<Media> media;
  final List<Author> authors;

  MostReadArticle({
    required this.id,
    required this.title,
    required this.slug,
    required this.categoryId,
    this.excerpt,
    required this.url,
    required this.category,
    required this.media,
    required this.authors,
  });

  factory MostReadArticle.fromJson(Map<String, dynamic> json) {
    return MostReadArticle(
      id: json['id'],
      title: json['title'],
      slug: json['slug'],
      categoryId: json['category_id'],
      excerpt: json['excerpt'],
      url: json['url'],
      category: Category.fromJson(json['category']),
      media: (json['media'] as List<dynamic>)
          .map((e) => Media.fromJson(e as Map<String, dynamic>))
          .toList(),
      authors: (json['authors'] as List<dynamic>)
          .map((e) => Author.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Category {
  final int id;
  final String slug;
  final String name;

  Category({required this.id, required this.slug, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
    );
  }
}

class Media {
  final int id;
  final String title;
  final String name;
  final String? caption;
  final String storagePath;
  final int orderId;
  final String mimeType;
  final String type;
  final List<dynamic> photographers;
  final String createdAt;
  final String lastUsed;
  final String thumb;
  final String auto;

  Media({
    required this.id,
    required this.title,
    required this.name,
    this.caption,
    required this.storagePath,
    required this.orderId,
    required this.mimeType,
    required this.type,
    required this.photographers,
    required this.createdAt,
    required this.lastUsed,
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
      orderId: json['order_id'],
      mimeType: json['mime_type'],
      type: json['type'],
      photographers: json['photographers'],
      createdAt: json['created_at'],
      lastUsed: json['last_used'],
      thumb: json['thumb'],
      auto: json['auto'],
    );
  }
}

class Author {
  final int id;
  final String name;
  final String slug;
  final int featured;
  final int order;
  final String createdAt;
  final String updatedAt;

  Author({
    required this.id,
    required this.name,
    required this.slug,
    required this.featured,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      featured: json['featured'],
      order: json['order'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
