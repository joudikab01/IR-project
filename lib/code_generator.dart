void main() {
  // request('Delete', 'timeTableResponse', 'addTimeTable');
  entity({
    "title": "String",
    "category": "String",
    "inProgressTasks": "int",
    "completedTasks": "int"
  }, 'Project');
}

void entity(Map<String, String> map, String className) {
  /// Name
  String result = '''import 'package:equatable/equatable.dart';
  class ${className}Entity extends Equatable{
  ''';

  /// Fields
  map.forEach((key, value) => result = '''${result}final $value $key;
  ''');

  /// Constructor
  result = '''${result}const ${className}Entity({
  ''';
  map.forEach((key, value) => result = '''${result}required this.$key,
  ''');
  result = '''$result});
  ''';

  /// Props
  result = '''$result@override
  List<Object?> get props => [
  ''';
  map.forEach((key, value) => result = '''$result$key,
  ''');
  result = '''$result];
  ''';

  /// CopyWith
  result = '''$result${className}Model copyWith({
  ''';
  map.forEach((key, value) => result = '''${result}final $value? $key,
  ''');
  result = '''$result}) {
    return ${className}Model(
  ''';
  map.forEach((key, value) => result = '''$result$key: $key ?? this.$key,
  ''');
  result = '''$result);
}
  ''';

  /// Dummy
  result = '''
${result}factory ${className}Entity.dummy() {
    return const ${className}Entity(
''';
  map.forEach((key, value) => result = '''$result$key: '',
  ''');
  result = '''$result);
  }''';
  result = '''$result}''';

  print(result);
}

void request(String model, String response, String funcName) {
  print('''

ApiResponse<$model>? _$response;

ApiResponse<$model>? get $response => _$response;

set $response(ApiResponse<$model>? value) {
  _$response = value;
  notifyListeners();
}

Future<ApiResponse<$model>> $funcName() async {
  ApiService apiService = ApiService(Dio());
  if (await checkInternet()) {
    $response = ApiResponse.loading('');
    try {
      $model ${model.toLowerCase()} = await apiService.$funcName();
  $response = ApiResponse.completed(${model.toLowerCase()});
  } catch (e) {
  if (e is DioError) {
  try {
  throwCustomException(e);
  } catch (forcedException) {
  return $response =
  ApiResponse.error(forcedException.toString());
  }
  }
  return $response = ApiResponse.error(e.toString());
  }
  } else {
  return $response = ApiResponse.error('No Internet Connection');
  }
  return
  $response
  !;
}''');
}
