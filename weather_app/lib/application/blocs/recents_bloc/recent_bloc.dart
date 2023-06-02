import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/recent_entity.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentBloc extends Bloc<RecentEvent, RecentState> {
  RecentBloc() : super(RecentInitial()) {
    on<RecentEvent>((event, emit) {
      if (event is AddLocationToRecent) {
        emit(state.copyWith(
            recents: List.of(state.recents)
              ..add(RecentEntity(name: event.name, region: event.region, country: event.country))));
      } else if (event is DeleteLocationOfList) {
        emit(state.copyWith(recents: List.of(state.recents)..removeAt(event.index)));
      }
    });
  }
}
