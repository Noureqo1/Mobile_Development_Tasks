class NewsArticle {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final DateTime publishedAt;
  bool isFavorite;

  NewsArticle({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.publishedAt,
    this.isFavorite = false,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No Description',
      imageUrl: json['imageUrl'] as String? ?? '',
      category: json['category'] as String? ?? 'General',
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'] as String)
          : DateTime.now(),
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'category': category,
      'publishedAt': publishedAt.toIso8601String(),
      'isFavorite': isFavorite,
    };
  }
}
