part of 'episode_bloc.dart';

abstract class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object> get props => [];
}

class LoadEpisodeBySeasonID extends EpisodeEvent {
  final String seasonID;
  final String streamID;
  const LoadEpisodeBySeasonID({
    required this.seasonID,
    required this.streamID,
  });

  @override
  List<Object> get props => [seasonID, streamID];
}
