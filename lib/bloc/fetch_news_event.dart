part of 'fetch_news_bloc.dart';

sealed class FetchNewsEvent extends Equatable {
  const FetchNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchNews extends FetchNewsEvent {}
