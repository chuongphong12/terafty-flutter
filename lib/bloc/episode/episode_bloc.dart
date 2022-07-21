import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/episode_model.dart';
import 'package:terafty_flutter/repository/streaming_repository.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final StreamingRepository _streamingRepository;
  EpisodeBloc({required StreamingRepository streamingRepository})
      : _streamingRepository = streamingRepository,
        super(EpisodeInitial()) {
    on<LoadEpisodeBySeasonID>((event, emit) async {
      emit(EpisodeLoading());
      try {
        List<Episode> episodeData = await _streamingRepository.getAllEpisodeByStreamIDAndSeason(
          seasonID: event.seasonID,
          streamID: event.streamID,
        );
        emit(EpisodeLoaded(episodes: episodeData));
      } catch (e) {
        emit(
          EpisodeFailure(error: e.toString()),
        );
      }
    });
  }
}
