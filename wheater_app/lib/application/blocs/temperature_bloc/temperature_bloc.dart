import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'temperature_event.dart';
part 'temperature_state.dart';

class TemperatureBloc extends Bloc<TemperatureEvent, TemperatureState> {
  TemperatureBloc() : super(TemperatureInitial()) {
    on<TemperatureEvent>((event, emit) {
      if (event is ChangeTempEvent) {
        emit(state.copyWith(isF: event.isF));
      }
    });
  }
}
