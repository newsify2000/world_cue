class NewsModel {
  final String id;
  final String title;
  final String description;
  final String summary;
  final String content;
  final String url;
  final String image;
  final String publishedAt;
  final String lang;
  final NewsSource source;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.summary,
    required this.content,
    required this.url,
    required this.image,
    required this.publishedAt,
    required this.lang,
    required this.source,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final source = json['source'] ?? {};

    return NewsModel(
      id: (json['id'] ?? '').toString().isEmpty
          ? "unknown_id"
          : json['id'].toString(),
      title: (json['title'] ?? '').toString().trim().isEmpty
          ? "No Title Available"
          : json['title'].toString().trim(),
      description: (json['description'] ?? '').toString().trim().isEmpty
          ? "No Description Available"
          : json['description'].toString().trim(),
      summary: (json['summary'] ?? '').toString().trim().isEmpty
          ? (json['description'] ?? '').toString().trim().isEmpty
          ? "No Description Available"
          : json['description'].toString().trim()
          : json['summary'].toString().trim(),
      content: (json['content'] ?? '').toString().trim().isEmpty
          ? "No Content Available"
          : json['content'].toString().trim(),
      url: (json['url'] ?? '').toString().trim().isEmpty
          ? "https://news.google.com/"
          : json['url'].toString().trim(),
      image: (json['image'] ?? '').toString().trim().isEmpty
          ? "no_image_url"
          : json['image'].toString().trim(),
      publishedAt: (json['publishedAt'] ?? '').toString().trim().isEmpty
          ? "NotAvailable"
          : json['publishedAt'].toString().trim(),
      lang: (json['lang'] ?? '').toString().trim().isEmpty
          ? "en"
          : json['lang'].toString().trim(),
      source: NewsSource.fromJson(source),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "summary": summary,
    "content": content,
    "url": url,
    "image": image,
    "publishedAt": publishedAt,
    "lang": lang,
    "source": source.toJson(),
  };

  @override
  String toString() =>
      'NewsModel(id: $id, title: $title, source: ${source.name})';
}

class NewsSource {
  final String id;
  final String name;
  final String url;

  NewsSource({
    required this.id,
    required this.name,
    required this.url,
  });

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(
      id: (json['id'] ?? '').toString().trim().isEmpty
          ? "unknown_source_id"
          : json['id'].toString(),
      name: (json['name'] ?? '').toString().trim().isEmpty
          ? "UnknownSource"
          : json['name'].toString().trim(),
      url: (json['url'] ?? '').toString().trim().isEmpty
          ? "https://example.com"
          : json['url'].toString().trim(),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "url": url,
  };
}
