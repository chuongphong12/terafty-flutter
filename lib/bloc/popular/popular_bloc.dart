import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:terafty_flutter/models/popular_content_model.dart';
import 'package:terafty_flutter/repository/popular_repository.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final PopularRepository _popularRepository;
  PopularBloc({required PopularRepository popularRepository})
      : _popularRepository = popularRepository,
        super(PopularInitial()) {
    on<LoadPopularContent>((event, emit) async {
      emit(PopularLoading());
      try {
        List<Doc> content = await _popularRepository.getPopularContent();
        List<dynamic> banners = await _popularRepository.getBanner();
        emit(PopularLoaded(popular: content, banners: banners));
      } catch (e) {
        emit(PopularFailure(error: e.toString()));
      }
    });
  }
}
