import 'dart:convert';

import 'package:ir/features/search/data/models/query_suggestion_model.dart';
import 'package:ir/features/search/domain/entities/query_suggestion_entity.dart';

import '../../../../core/const/api.dart';
import '../../../../core/data_sources/http_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/models/error_response_model.dart';
import '../../../../core/models/failure_response_model.dart';
import '../../domain/entities/search_result_entity.dart';
import '../models/search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchResultEntity> search(
      {required String query, required String dataset,required String type,});
  Future<QuerySuggestionEntity> getQuerySuggestion(
      {required String query, required String dataset});
}

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final HttpService client;

  SearchRemoteDataSourceImpl({required this.client});

  @override
  Future<SearchResultEntity> search({
    required String query,
    required String dataset,
    required String type,
  }) async {
    var url = Uri.parse("${test.baseURL}${API.searchResults}?query=$query&dataset=$dataset&search_type=$type");
    final response =
        await client.get(url).timeout(const Duration(seconds: API.timeout));
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return SearchResultModel.fromJson(json.decode(response.body),query);
    }
    if (response.statusCode == 422) {
      var errorResponse =
          ErrorResponseModel.fromJson(json.decode(response.body));
      throw ServerException(message: errorResponse.message ?? "");
    }
    var errorResponse =
        FailureResponseModel.fromJson(json.decode(response.body));
    throw ServerException(message: errorResponse.message);
  }

  @override
  Future<QuerySuggestionEntity> getQuerySuggestion({
    required String query,
    required String dataset,
  }) async {
    var url = Uri.parse("${test.baseURL}${API.querySuggestions}?query=$query&dataset=$dataset");
    final response =
        await client.get(url).timeout(const Duration(seconds: API.timeout));
    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return QuerySuggestionModel.fromJson(json.decode(response.body));
    }
    if (response.statusCode == 422) {
      var errorResponse =
          ErrorResponseModel.fromJson(json.decode(response.body));
      throw ServerException(message: errorResponse.message ?? "");
    }
    var errorResponse =
        FailureResponseModel.fromJson(json.decode(response.body));
    throw ServerException(message: errorResponse.message);
  }
}
