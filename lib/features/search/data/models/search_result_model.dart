import 'package:ir/features/search/data/models/doc_model.dart';
import 'package:ir/features/search/domain/entities/search_result_entity.dart';

class SearchResultModel extends SearchResultEntity {
  const SearchResultModel({
    required super.autoCorrect,
    required super.data,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> data, String query) {
    return SearchResultModel(
      autoCorrect: query == data['auto_correct']? null : data['auto_correct'],
      data: (data['data']as List).map((e) => DocModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "auto_correct": autoCorrect,
      "data": data,
    };
    return map;
  }
}
