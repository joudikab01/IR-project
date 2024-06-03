import 'package:ir/features/search/domain/entities/doc_entity.dart';

class DocModel extends DocEntity {
  const DocModel({
    required super.id,
    required super.index,
    required super.text,
  });

  factory DocModel.fromJson(Map<String, dynamic> data) {
    return DocModel(
      id: data['_id'],
      index: data['index'],
      text: data['text'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "_id": id,
      "index": index,
      "text": text,
    };
    return map;
  }
}
