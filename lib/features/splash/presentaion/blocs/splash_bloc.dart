import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitialState()) {
    on<SplashEvent>(
      (event, emit) async {
        if (event is StartSplashTimer) {
          emit(SplashLoadingState());
          await Future.delayed(
            Duration(seconds: event.timer),
            () async {
              emit(SplashLoadedState());
            },
          );
        }
      },
    );
  }
}
