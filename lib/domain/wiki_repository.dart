import 'package:flutter_example/domain/page_entry.dart';

abstract class WikiRepository {

  Future<List<PageEntry>> searchWiki(String query);
  
}