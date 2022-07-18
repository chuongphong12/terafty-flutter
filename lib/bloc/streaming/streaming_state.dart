part of 'streaming_bloc.dart';

abstract class StreamingState extends Equatable {
  const StreamingState();

  @override
  List<Object> get props => [];
}

class StreamingInitial extends StreamingState {}

class StreamingLoading extends StreamingState {}

class StreamingLoaded extends StreamingState {
  final StreamingData streaming;

  const StreamingLoaded({required this.streaming});

  @override
  List<Object> get props => [streaming];
}

class StreamingFailure extends StreamingState {
  final String error;
  const StreamingFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
