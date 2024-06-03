import 'package:equatable/equatable.dart';
import 'package:ir/features/search/data/models/doc_model.dart';

class DocEntity extends Equatable {
  final String? id;
  final int? index;
  final String text;

  const DocEntity({
    required this.id,
    required this.index,
    required this.text,
  });

  @override
  List<Object?> get props => [
        id,
        index,
        text,
      ];

  DocModel copyWith({
    final String? id,
    final int? index,
    final String? text,
  }) {
    return DocModel(
      id: id ?? this.id,
      index: index ?? this.index,
      text: text ?? this.text,
    );
  }
}
