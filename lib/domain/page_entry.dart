import 'package:meta/meta.dart';

class PageEntry {
  PageEntry({
    @required this.pageId,
    @required this.title,
    @required this.description,
    this.thumbnail,
  })  : assert(title != null),
        assert(pageId != null);

  final int pageId;
  final String title;
  final String description;
  final String thumbnail;
  //
  // Entry.fromJson(Map<String, dynamic> json)
  //     : title = json['title'],
  //       description = json['description'],
  //       thumbnail = json['thumbnail'];
  //
  // Map<String, dynamic> toJson() => {
  //       'title': title,
  //       'description': description,
  //       'thumbnail': thumbnail,
  //     };
}
