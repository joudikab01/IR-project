part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

/// Search
class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  const SearchErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class SearchSuccessState extends SearchState {
  final SearchResultEntity searchResultEntity;

  const SearchSuccessState({required this.searchResultEntity});

  @override
  List<Object> get props => [searchResultEntity];
}

/// Query Suggestion
class QuerySuggestionLoadingState extends SearchState {}

class QuerySuggestionErrorState extends SearchState {
  final String message;

  const QuerySuggestionErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class QuerySuggestionSuccessState extends SearchState {
  final QuerySuggestionEntity querySuggestionEntity;

  const QuerySuggestionSuccessState({required this.querySuggestionEntity});

  @override
  List<Object> get props => [querySuggestionEntity];
}
