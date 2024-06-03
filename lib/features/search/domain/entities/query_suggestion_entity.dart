import 'package:equatable/equatable.dart';
import 'package:ir/features/search/data/models/query_suggestion_model.dart';

class QuerySuggestionEntity extends Equatable {
  final List<String> queries;
  const QuerySuggestionEntity({required this.queries});

  @override
  List<Object?> get props => [queries];

  QuerySuggestionModel copyWith({
    final List<String>? queries,
  }) {
    return QuerySuggestionModel(
      queries: queries ?? this.queries,
    );
  }
}
