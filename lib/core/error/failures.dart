import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  const Failure([this.properties = const <dynamic>[]]);

  @override
  List<Object> get props => [properties];
}

class CacheFailure extends Failure {
  final String message;

  CacheFailure({required this.message}) : super([message]);
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message}) : super([message]);
}
