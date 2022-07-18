part of 'streaming_bloc.dart';

abstract class StreamingEvent extends Equatable {
  const StreamingEvent();

  @override
  List<Object> get props => [];
}

class LoadSteamingDetail extends StreamingEvent {
  final String? id;
  const LoadSteamingDetail({
    required this.id,
  });

  @override
  List<Object> get props => [];
}
