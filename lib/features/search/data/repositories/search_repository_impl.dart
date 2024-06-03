import 'package:dartz/dartz.dart';
import 'package:ir/features/search/domain/entities/query_suggestion_entity.dart';
import 'package:ir/features/search/domain/entities/search_result_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/repositories/base_repository.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';

class SearchRepositoryImpl extends BaseRepositoryImpl
    implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, SearchResultEntity>> search(
      {required String query, required String dataset,required String type,}) async {
    return remoteRequest<SearchResultEntity>(() async {
      return await remoteDataSource.search(query: query, dataset: dataset,type: type);
    });
  }

  @override
  Future<Either<Failure, QuerySuggestionEntity>> getQuerySuggestion(
      {required String query, required String dataset}) async {
    return remoteRequest<QuerySuggestionEntity>(() async {
      return await remoteDataSource.getQuerySuggestion(
          query: query, dataset: dataset);
    });
  }
}
