part of 'search_bloc.dart';

class SearchState {}

class LoadSearchState extends SearchState {}

class LoadedSearchState extends SearchState {
  final List<SearchLocation> locationResult;
  LoadedSearchState({this.locationResult = const []});

  LoadedSearchState copyWith({List<SearchLocation>? locationResult}) =>
      LoadedSearchState(locationResult: locationResult ?? this.locationResult);
}
