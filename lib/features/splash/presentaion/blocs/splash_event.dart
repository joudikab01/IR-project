part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
}

class StartSplashTimer extends SplashEvent {
  final int timer;

  const StartSplashTimer({required this.timer});

  @override
  List<Object?> get props => [timer];
}
