import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'color_event.dart';
part 'color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState(Colors.blueGrey, 300, 300)) {
    on<RedColorEvent>((event, emit) {
      emit(const ColorState(Colors.red, 100, 100));
    });

    on<BlueColorEvent>((event, emit) {
      emit(const ColorState(Colors.blue, 200, 200));
    });
    on<BlueGreyColorEvent>((event, emit) {
      emit(const ColorState(Colors.blueGrey, 300, 300));
    });
  }
}
