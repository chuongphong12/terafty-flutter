import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/vote_model.dart';

import '../../repository/streaming_repository.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  final StreamingRepository _streamingRepository;

  VoteBloc({required StreamingRepository streamingRepository})
      : _streamingRepository = streamingRepository,
        super(VoteInitial()) {
    on<LoadVoteByEpisode>((event, emit) async {
      emit(VoteLoading());
      try {
        VoteData data = await _streamingRepository.getVoteByEpisode(
          seasonId: event.seasonID,
          streamingId: event.streamingID,
          episodeId: event.episodesID,
        );
        emit(VoteLoaded(vote: data));
      } catch (e) {
        emit(VoteLoadFailure(error: e.toString()));
      }
    });
  }
}
