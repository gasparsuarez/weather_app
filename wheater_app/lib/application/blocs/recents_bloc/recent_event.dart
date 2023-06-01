part of 'recent_bloc.dart';

abstract class RecentEvent extends Equatable {
  const RecentEvent();

  @override
  List<Object> get props => [];
}

class AddLocationToRecent extends RecentEvent {
  final String name;
  final String region;
  final String country;

  const AddLocationToRecent({required this.name, required this.region, required this.country});
}

class DeleteLocationOfList extends RecentEvent {
  final int index;

  const DeleteLocationOfList({required this.index});
}
