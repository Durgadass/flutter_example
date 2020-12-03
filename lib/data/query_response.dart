import 'package:flutter_example/data/page_response.dart';

class QueryResponse {
  QueryResponse({this.pages});

  final List<PageResponse> pages;

  QueryResponse.fromJson(Map<String, dynamic> json)
      : pages = json['pages'].map((e) => PageResponse.fromJson(e)).toList().cast<PageResponse>();
}
