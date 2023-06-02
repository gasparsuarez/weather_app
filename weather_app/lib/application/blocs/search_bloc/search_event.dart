part of 'search_bloc.dart';

abstract class SearchEvent {
  const SearchEvent();
}

class LocationChangedEvent extends SearchEvent with EquatableMixin {
  final String location;

  LocationChangedEvent({required this.location});
  @override
  List<Object?> get props => [location];
}

class ResetListEvent extends SearchEvent {}
