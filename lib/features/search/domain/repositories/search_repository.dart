import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ir/core/error/failures.dart';
import 'package:ir/features/search/domain/entities/query_suggestion_entity.dart';
import 'package:ir/features/search/domain/entities/search_result_entity.dart';

import '../../../../core/repositories/base_repository.dart';

abstract class SearchRepository extends BaseRepository {
  Future<Either<Failure, SearchResultEntity>> search(
      {required String query, required String dataset,required String type,});
  Future<Either<Failure, QuerySuggestionEntity>> getQuerySuggestion(
      {required String query, required String dataset});
}
