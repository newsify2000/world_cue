class NewsModel {
  final String title;
  final String link;
  final String imageLink;
  final String description;
  final String publishedAt;
  final String sourceName;
  final String sourceLink;

  NewsModel({
    required this.title,
    required this.link,
    required this.imageLink,
    required this.description,
    required this.publishedAt,
    required this.sourceName,
    required this.sourceLink,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      imageLink: json['imageLink'] ?? '',
      description: json['description'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      sourceName: json['sourceName'] ?? '',
      sourceLink: json['sourceLink'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'imageLink': imageLink,
      'description': description,
      'publishedAt': publishedAt,
      'sourceName': sourceName,
      'sourceLink': sourceLink,
    };
  }

  @override
  String toString() {
    return 'NewsModel('
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
