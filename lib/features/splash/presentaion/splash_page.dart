import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/style/assets/assets.gen.dart';
import '../../search/presentation/pages/search_page.dart';
import 'blocs/splash_bloc.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final int duration = 400;
  final int delay = 600;
  int stage = 1;
  bool scale = false;

  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(const StartSplashTimer(timer: 3));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            Navigator.pushReplacementNamed(context, SearchPage.routeName);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.svgs.splash
                .svg(width: MediaQuery.sizeOf(context).width / 1.5),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.displaySmall!,
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Information Retrieval'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
