import 'package:equatable/equatable.dart';
import 'package:ir/features/search/domain/entities/doc_entity.dart';

class SearchResultEntity extends Equatable {
  final String? autoCorrect;
  final List<DocEntity> data;

  const SearchResultEntity({
    required this.autoCorrect,
    required this.data,
  });

  @override
  List<Object?> get props => [
        autoCorrect,
        data,
      ];

  SearchResultEntity copyWith({
    final String? autoCorrect,
    final List<DocEntity>? data,
  }) {
    return SearchResultEntity(
      autoCorrect: autoCorrect ?? this.autoCorrect,
      data: data ?? this.data,
    );
  }
}
