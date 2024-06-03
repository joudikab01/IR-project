import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:ir/core/error/failures.dart';
import 'package:ir/core/usecases/usecase.dart';
import 'package:ir/features/search/domain/entities/search_result_entity.dart';
import 'package:ir/features/search/domain/repositories/search_repository.dart';

class SearchUseCase extends UseCase<SearchResultEntity, SearchParams> {
  final SearchRepository repository;

  SearchUseCase({required this.repository});

  @override
  Future<Either<Failure, SearchResultEntity>> call(
      {required SearchParams params}) async {
    return await repository.search(
        query: params.query, dataset: params.dataset,type: params.type);
  }
}

class SearchParams extends Equatable {
  final String query;
  final String dataset;
  final String type;

  const SearchParams({required this.query, required this.dataset,required this.type});

  @override
  List<Object?> get props => [query, dataset,type];
}
