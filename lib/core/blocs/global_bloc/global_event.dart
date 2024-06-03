part of 'global_bloc.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();
  @override
  List<Object?> get props => [];
}

class ChangeThemeEvent extends GlobalEvent {
  final ThemeMode themeMode;
  final BuildContext context;

  const ChangeThemeEvent({required this.themeMode, required this.context});

  @override
  List<Object?> get props => [themeMode, context];
}
