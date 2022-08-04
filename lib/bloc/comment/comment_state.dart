part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comments> comments;
  const CommentLoaded({
    required this.comments,
  });

  @override
  List<Object> get props => [comments];
}

class CommentLoadFailure extends CommentState {
  final String error;
  const CommentLoadFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CommentLoadFailure(error: $error)';
}
