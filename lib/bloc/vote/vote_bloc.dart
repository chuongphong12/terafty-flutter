import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/vote_model.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  VoteBloc() : super(VoteInitial()) {
    on<LoadVoteByEpisode>((event, emit) {
      emit(VoteLoading());
      try {
        
      } catch (e) {
        emit(VoteLoadFailure(error: e.toString()));
      }
    });
  }
}
