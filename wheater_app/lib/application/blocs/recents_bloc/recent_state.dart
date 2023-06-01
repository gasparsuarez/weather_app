part of 'recent_bloc.dart';

class RecentState extends Equatable {
  final List<RecentEntity> recents;
  const RecentState({this.recents = const []});

  RecentState copyWith({List<RecentEntity>? recents}) =>
      RecentState(recents: recents ?? this.recents);

  @override
  List<Object> get props => [recents];
}

class RecentInitial extends RecentState {}
