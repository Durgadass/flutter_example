class PageResponse {
  PageResponse({
    this.pageId,
    this.title,
    this.description,
    this.thumbnail,
  });

  final int pageId;
  final String title;
  final String description;
  final String thumbnail;

  PageResponse.fromJson(Map<String, dynamic> json)
      : pageId = json['id'],
        title = json['title'],
        description = json['description'],
        thumbnail = json['thumbnail'] == null ? null : json['thumbnail']['url'];
}
