import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/repositories/weather_repository.dart';

import '../../../domain/entities/search_location.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IWeatherRepository _iWeatherRepository;
  SearchBloc(this._iWeatherRepository) : super(SearchState()) {
    on<SearchEvent>((event, emit) async {
      emit(LoadSearchState());
      if (event is LocationChangedEvent) {
        final locationResult = await _iWeatherRepository.searchLocation(event.location);
        emit(LoadedSearchState(locationResult: List.of(locationResult)));
      }
      if (event is ResetListEvent) {
        emit(LoadedSearchState(locationResult: []));
      }
    });
  }
}
