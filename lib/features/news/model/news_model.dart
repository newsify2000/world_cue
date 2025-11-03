class NewsModel {
  final String id;
  final String title;
  final String link;
  final String imageLink;
  final String description;
  final String publishedAt;
  final String sourceName;
  final String sourceLink;

  NewsModel({
    required this.id,
    required this.title,
    required this.link,
    required this.imageLink,
    required this.description,
    required this.publishedAt,
    required this.sourceName,
    required this.sourceLink,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'] ?? {};

    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      link: json['url'] ?? '',
      imageLink: json['image'] ?? '',
      description: json['description'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      sourceName: source['name'] ?? '',
      sourceLink: source['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': link,
      'image': imageLink,
      'description': description,
      'publishedAt': publishedAt,
      'source': {
        'name': sourceName,
        'url': sourceLink,
      },
    };
  }

  @override
  String toString() {
    return 'NewsModel('
        'id: $id, '
        'title: $title, '
        'link: $link, '
        'imageLink: $imageLink, '
        'description: $description, '
        'publishedAt: $publishedAt, '
        'sourceName: $sourceName, '
        'sourceLink: $sourceLink'
        ')';
  }

}
