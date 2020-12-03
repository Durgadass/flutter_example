import 'package:flutter_example/domain/page_entry.dart';

abstract class WikiSearchCubitState {
  const WikiSearchCubitState();
}

class WikiSearchCubitInitial extends WikiSearchCubitState {
  const WikiSearchCubitInitial();

  @override
  String toString() => 'WikiSearchCubitInitial';
}

class WikiSearchCubitLoading extends WikiSearchCubitState {
  WikiSearchCubitLoading(this.query);

  final String query;

  @override
  String toString() => 'WikiSearchCubitLoading $query';
}

class WikiSearchCubitSuccess extends WikiSearchCubitState {
  WikiSearchCubitSuccess(this.query, this.result);

  final String query;
  final List<PageEntry> result;

  @override
  String toString() => 'WikiSearchCubitSuccess $query';
}

class WikiSearchCubitFailure extends WikiSearchCubitState {
  WikiSearchCubitFailure(this.query, this.message);

  final String query;
  final String message;

  @override
  String toString() => 'WikiSearchCubitFailure $query $message';
}
