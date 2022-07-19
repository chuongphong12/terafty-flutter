part of 'popular_bloc.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class PopularLoading extends PopularState {}

class PopularLoaded extends PopularState {
  final List<Doc> popular;
  final List<dynamic> banners;
  const PopularLoaded({
    required this.banners,
    required this.popular,
  });

  @override
  List<Object> get props => [popular, banners];
}

class PopularFailure extends PopularState {
  final String error;
  const PopularFailure({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
