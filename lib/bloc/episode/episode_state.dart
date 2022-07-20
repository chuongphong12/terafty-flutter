part of 'episode_bloc.dart';

abstract class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object> get props => [];
}

class EpisodeInitial extends EpisodeState {}

class EpisodeLoading extends EpisodeState {}

class EpisodeLoaded extends EpisodeState {
  final List<Episode> episodes;
  const EpisodeLoaded({
    required this.episodes,
  });

  @override
  List<Object> get props => [episodes];
}

class EpisodeFailure extends EpisodeState {
  final String error;
  const EpisodeFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
