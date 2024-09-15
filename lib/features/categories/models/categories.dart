class Category {
  final int id;
  final String name;
  final String slug;
  final String? color;
  final int? parentId;
  final int order;
  final int statusId;
  final String createdAt;
  final String updatedAt;
  final MetaData? metaData;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    this.color,
    this.parentId,
    required this.order,
    required this.statusId,
    required this.createdAt,
    required this.updatedAt,
    this.metaData,
    required this.children,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      color: json['color'],
      parentId: json['parent_id'],
      order: json['order'],
      statusId: json['status_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      metaData: json['meta_data'] != null
          ? MetaData.fromJson(json['meta_data'])
          : null,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class MetaData {
  final int? limit;
  final String? template;
  final String? secondary;
  final String? description;
  final String? parentView;
  final String? singleView;

  MetaData({
    this.limit,
    this.template,
    this.secondary,
    this.description,
    this.parentView,
    this.singleView,
  });

  factory MetaData.fromJson(Map<String, dynamic>? json) {
    return MetaData(
      limit: json?['limit'] is String
          ? int.tryParse(json?['limit'])
          : json?['limit'],
      template: json?['template'],
      secondary: json?['secondary'],
      description: json?['description'],
      parentView: json?['parent_view'],
      singleView: json?['single_view'],
    );
  }
}
