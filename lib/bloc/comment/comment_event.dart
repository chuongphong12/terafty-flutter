part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class LoadCommentFromApi extends CommentEvent {
  final String streamID;
  final String episodeID;

  const LoadCommentFromApi({
    required this.streamID,
    required this.episodeID,
  });

  @override
  List<Object> get props => [streamID, episodeID];
}

class SubmitComment extends CommentEvent {
  final String streamID;
  final String episodeID;
  final String comment;
  const SubmitComment({
    required this.streamID,
    required this.episodeID,
    required this.comment,
  });

  @override
  List<Object> get props => [streamID, episodeID, comment];
}

class LikeComment extends CommentEvent {
  final String streamID;
  final String episodeID;
  const LikeComment({
    required this.streamID,
    required this.episodeID,
  });

  @override
  List<Object> get props => [streamID, episodeID];
}
