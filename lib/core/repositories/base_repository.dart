import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

typedef RequestBody<T> = Future<T> Function();

abstract class BaseRepository {
  Future<Either<Failure, T>> remoteRequest<T>(RequestBody<T> body);
}

class BaseRepositoryImpl extends BaseRepository {
  @override
  Future<Either<Failure, T>> remoteRequest<T>(RequestBody<T> body) async {
    try {
      final T t = await body();
      return Right(t);
    } on ServerException catch (e) {
      log(e.message.toString(), name: "ServerException");
      return Left(ServerFailure(message: e.message));
    } on CacheException catch (e) {
      log(e.message.toString(), name: "CacheException");
      return Left(CacheFailure(message: "somethingWentWrong"));
    } on TimeoutException catch (e) {
      log(e.message.toString(), name: "TimeoutException");
      return Left(ServerFailure(message: "timeout"));
    } on SocketException catch (e) {
      log(e.toString(), name: "SocketException");
      if (e.osError != null && e.osError!.errorCode == 111) {
        return Left(ServerFailure(message: "somethingWentWrong"));
      }
      return Left(ServerFailure(message: "noInternetConnection"));
    } on Error catch (e) {
      log(e.toString(), name: "Error");
      return Left(ServerFailure(message: "somethingWentWrong"));
    } on Exception catch (e) {
      log(e.toString(), name: "Exception");
      return Left(ServerFailure(message: "somethingWentWrong"));
    }
  }
}
