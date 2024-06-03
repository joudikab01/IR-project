import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/blocs/global_bloc/global_bloc.dart';
import 'core/style/theme.dart';
import 'core/utils/routes.dart';
import 'dependency_injection.dart' as dii;
import 'dependency_injection.dart';
import 'features/splash/presentaion/splash_page.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dii.inject();
  await Hive.initFlutter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<GlobalBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalBloc, GlobalState>(
      builder: (context, state) {
        return MaterialApp(
          navigatorKey: navigationKey,
          debugShowCheckedModeBanner: false,
          theme: const MaterialTheme().light(),
          darkTheme: const MaterialTheme().dark(),
          themeMode: context.read<GlobalBloc>().mode,
          initialRoute: SplashPage.routeName,
          onGenerateRoute: onGenerateRoutes,
        );
      },
    );
  }
}
