import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_event.dart';
part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  ThemeMode mode = ThemeMode.light;
  GlobalBloc() : super(GlobalInitialState()) {
    on<GlobalEvent>((event, emit) async {
      if (event is ChangeThemeEvent) {
        mode = event.themeMode;
        emit(ChangeThemeSuccessState(themeMode: event.themeMode));
      }
    });
  }
}
