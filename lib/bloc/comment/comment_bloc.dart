import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/comment_model.dart';
import 'package:terafty_flutter/repository/streaming_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final StreamingRepository _streamingRepository;
  CommentBloc({required StreamingRepository streamingRepository})
      : _streamingRepository = streamingRepository,
        super(CommentInitial()) {
    on<LoadCommentFromApi>((event, emit) async {
      List<Comments> comments;
      emit(CommentLoading());
      try {
        comments = await _streamingRepository.getCommentByEpisode(
            streamingId: event.streamID, episodeId: event.episodeID);
        emit(CommentLoaded(comments: comments));
      } catch (e) {
        emit(CommentLoadFailure(error: e.toString()));
      }
    });
  }
}
