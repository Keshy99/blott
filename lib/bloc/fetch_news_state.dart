part of 'fetch_news_bloc.dart';

sealed class FetchNewsState extends Equatable {
  const FetchNewsState();
  
  @override
  List<Object> get props => [];
}

final class FetchNewsInitial extends FetchNewsState {}

final class FetchNewsLoading extends FetchNewsState {}

final class FetchNewsLoaded extends FetchNewsState {
  final dynamic news;

  const FetchNewsLoaded({required this.news});

  @override
  List<Object> get props => [news];
}

final class FetchNewsError extends FetchNewsState {
  final String message;

  const FetchNewsError({required this.message});

  @override
  List<Object> get props => [message];
}


