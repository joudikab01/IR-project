import 'package:ir/features/search/domain/entities/query_suggestion_entity.dart';

class QuerySuggestionModel extends QuerySuggestionEntity {
  const QuerySuggestionModel({required super.queries});

  factory QuerySuggestionModel.fromJson(Map<String, dynamic> data) {
    return QuerySuggestionModel(queries: (data['data'] as List).map((e) => e.toString()).toList());
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {"data": queries};
    return map;
  }
}
