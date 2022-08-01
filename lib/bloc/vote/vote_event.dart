part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

class LoadVoteByEpisode extends VoteEvent {
  final String streamingID;
  final String seasonID;
  final String episodesID;

  const LoadVoteByEpisode({
    required this.streamingID,
    required this.seasonID,
    required this.episodesID,
  });

  @override
  List<Object> get props => [streamingID, seasonID, episodesID];
}
