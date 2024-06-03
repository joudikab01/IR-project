import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ir/core/error/failures.dart';
import 'package:ir/core/usecases/usecase.dart';
import 'package:ir/features/search/domain/entities/query_suggestion_entity.dart';
import 'package:ir/features/search/domain/repositories/search_repository.dart';

class GetQuerySuggestionUseCase
    extends UseCase<QuerySuggestionEntity, GetQuerySuggestionParams> {
  final SearchRepository repository;

  GetQuerySuggestionUseCase({required this.repository});

  @override
  Future<Either<Failure, QuerySuggestionEntity>> call(
      {required GetQuerySuggestionParams params}) async {
    return await repository.getQuerySuggestion(
        query: params.query, dataset: params.dataset);
  }
}
class GetQuerySuggestionParams extends Equatable {
  final String query;
  final String dataset;

  const GetQuerySuggestionParams({required this.query, required this.dataset});

  @override
  List<Object?> get props => [query, dataset];
}