part of 'global_bloc.dart';

abstract class GlobalState extends Equatable {
  const GlobalState();
  @override
  List<Object> get props => [];
}

class GlobalInitialState extends GlobalState {}

class ChangeThemeSuccessState extends GlobalState {
  final ThemeMode themeMode;

  const ChangeThemeSuccessState({required this.themeMode});
  @override
  List<Object> get props => [themeMode];
}
