
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/domain/wiki_repository.dart';
import 'package:flutter_example/view/wiki_search_states.dart';

class WikiSearchCubit extends Cubit<WikiSearchCubitState>{
  WikiSearchCubit(this.repository) : super(const WikiSearchCubitInitial());

  final WikiRepository repository;

  void searchWiki(String query) async {
    try {
      emit(WikiSearchCubitLoading(query));
      final result = await repository.searchWiki(query);
      emit(WikiSearchCubitSuccess(query, result));
    } catch (e, stackTrace) {
      print(stackTrace);
      emit(WikiSearchCubitFailure(query, e.toString()));
    }
  }
}