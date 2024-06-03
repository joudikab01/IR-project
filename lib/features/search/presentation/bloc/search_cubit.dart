import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ir/features/search/domain/entities/query_suggestion_entity.dart';
import 'package:ir/features/search/domain/entities/search_result_entity.dart';

import '../../domain/use_cases/get_query_suggestion_usecase.dart';
import '../../domain/use_cases/search_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchUseCase searchUseCase;
  final GetQuerySuggestionUseCase getQuerySuggestionUseCase;
  SearchCubit({
    required this.searchUseCase,
    required this.getQuerySuggestionUseCase,
  }) : super(SearchInitial());

  Future<void> search(String query, String dataset, String type) async {
    emit(SearchLoadingState());
    var result = await searchUseCase.call(
        params: SearchParams(query: query, dataset: dataset,type: type));
    result.fold(
      (l) => emit(SearchErrorState(message: l.toString())),
      (r) => emit(SearchSuccessState(searchResultEntity: r)),
    );
  }

  Future<void> getQuerySuggestion(String query, String dataset) async {
    emit(QuerySuggestionLoadingState());
    var result = await getQuerySuggestionUseCase.call(
        params: GetQuerySuggestionParams(query: query, dataset: dataset));
    result.fold(
      (l) => emit(QuerySuggestionErrorState(message: l.toString())),
      (r) => emit(QuerySuggestionSuccessState(querySuggestionEntity: r)),
    );
  }
}
