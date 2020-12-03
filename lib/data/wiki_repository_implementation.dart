import 'package:dio/dio.dart';
import 'package:flutter_example/data/query_response.dart';
import 'package:flutter_example/domain/page_entry.dart';
import 'package:flutter_example/domain/wiki_repository.dart';
import 'package:flutter_example/util.dart';

class WikiRepositoryImplementation implements WikiRepository {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://en.wikipedia.org/w/rest.php/v1',
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ),
  );

  WikiRepositoryImplementation() {
    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }

  @override
  Future<List<PageEntry>> searchWiki(String query) async {
    try {
      final response = await dio.get(
        "/search/page",
        queryParameters: {"q": query, "limit": 20},
      );
      final result = QueryResponse.fromJson(response.data).pages
          .map(
            (page) => PageEntry(
              pageId: page.pageId,
              title: page.title,
              description: page.description,
              thumbnail: page.thumbnail,
            ),
          )
          .toList();
      return result;
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      rethrow;
    }
  }
}
