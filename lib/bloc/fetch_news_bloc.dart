import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'fetch_news_event.dart';
part 'fetch_news_state.dart';

class FetchNewsBloc extends Bloc<FetchNewsEvent, FetchNewsState> {
  final String apiKey = 'crals9pr01qhk4bqotb0crals9pr01qhk4bqotbg';

  FetchNewsBloc() : super(FetchNewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(FetchNewsLoading());

      try {
        final response = await http.get(
          Uri.parse('https://finnhub.io/api/v1/news?category=general'),
          headers: {
            'X-Finnhub-Token': apiKey, // Sending the API key as a header
          },
        );
        print(response.body);
        if (response.statusCode == 200) {
          final news = json.decode(response.body);
          emit(FetchNewsLoaded(news: news));
        } else {
          emit(
            FetchNewsError(
              message: 'Failed to fetch news: ${response.reasonPhrase}',
            ),
          );
        }
      } catch (e) {
        emit(FetchNewsError(message: e.toString()));
      }
    });
  }
}
