part of 'vote_bloc.dart';

abstract class VoteState extends Equatable {
  const VoteState();

  @override
  List<Object> get props => [];
}

class VoteInitial extends VoteState {}

class VoteLoading extends VoteState {}

class VoteLoaded extends VoteState {
  final VoteData vote;
  const VoteLoaded({
    required this.vote,
  });

  @override
  List<Object> get props => [vote];
}

class VoteLoadFailure extends VoteState {
  final String error;
  const VoteLoadFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'VoteLoadFailure(error: $error)';
}
