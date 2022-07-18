import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/streaming_model.dart';
import 'package:terafty_flutter/repository/streaming_repository.dart';

part 'streaming_event.dart';
part 'streaming_state.dart';

class StreamingBloc extends Bloc<StreamingEvent, StreamingState> {
  final StreamingRepository _streamingRepository;
  StreamingBloc({required StreamingRepository streamingRepository})
      : _streamingRepository = streamingRepository,
        super(StreamingInitial()) {
    on<LoadSteamingDetail>((event, emit) async {
      emit(StreamingLoading());
      try {
        StreamingData streamData = await _streamingRepository.getStreamingDetail(event.id);
        emit(StreamingLoaded(streaming: streamData));
      } catch (e) {
        emit(
          StreamingFailure(error: e.toString()),
        );
      }
    });
  }
}
