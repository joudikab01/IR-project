import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';
import 'package:ir/features/search/domain/use_cases/get_query_suggestion_usecase.dart';
import 'package:ir/features/search/domain/use_cases/search_usecase.dart';
import 'package:ir/features/search/presentation/bloc/search_cubit.dart';

import 'core/blocs/global_bloc/global_bloc.dart';
import 'core/const/api.dart';
import 'core/data_sources/http_client.dart';
import 'features/search/data/data_sources/search_remote_data_source.dart';
import 'features/search/data/repositories/search_repository_impl.dart';
import 'features/search/domain/repositories/search_repository.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/presentaion/blocs/splash_bloc.dart';

final di = GetIt.instance;

Future<void> inject() async {
  di.registerLazySingleton<Client>(() => Client());
  di.registerLazySingleton<RetryClient>(
    () => RetryClient(
      di(),
    ),
  );
  di.registerLazySingleton<HttpService>(() => HttpService(
        client: di(),
        unauthorizedRoutes: [
          API.searchResults,
          API.querySuggestions,
        ],
      ));
  di.registerFactory<GlobalBloc>(() => GlobalBloc());

  /// ========================== Splash ========================== ///
  di.registerLazySingleton<SplashRepository>(() => SplashRepositoryImpl());
  di.registerFactory<SplashBloc>(() => SplashBloc());

  /// ========================== Search ========================== ///
  di.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(client: di()));
  di.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImpl(remoteDataSource: di()));
  di.registerLazySingleton<SearchUseCase>(
      () => SearchUseCase(repository: di()));
  di.registerLazySingleton<GetQuerySuggestionUseCase>(
      () => GetQuerySuggestionUseCase(repository: di()));
  di.registerFactory<SearchCubit>(() => SearchCubit(searchUseCase: di(),
    getQuerySuggestionUseCase: di(),));
}
