import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ir/features/search/presentation/bloc/search_cubit.dart';

import '../../dependency_injection.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/splash/presentaion/blocs/splash_bloc.dart';
import '../../features/splash/presentaion/splash_page.dart';
import 'custom_page_route_builder.dart';

Route? onGenerateRoutes(settings) {
  /// SPLASH
  if (settings.name == SplashPage.routeName) {
    return CustomPageRouteBuilder(
      page: BlocProvider<SplashBloc>(
        create: (context) => di<SplashBloc>(),
        child: const SplashPage(),
      ),
      routeName: SplashPage.routeName,
    );
  }

  /// AUTH
  if (settings.name == SearchPage.routeName) {
    return CustomPageRouteBuilder(
      page: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => di<SearchCubit>()),
        ],
        child: const SearchPage(),
      ),
      routeName: SearchPage.routeName,
    );
  }
  return null;
}
