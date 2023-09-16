import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
import 'moviesearchevent.dart';
import 'moviesearchstate.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc() : super(MovieSearchInitial());


  @override
  Stream<MovieSearchState> mapEventToState(MovieSearchEvent event) async* {
    if (event is FetchMovie) {
      yield MovieSearchLoading();
      try {
        final movie = await fetchMovie(event.query);
        yield MovieSearchLoaded(movie);
      } catch (e) {
        yield MovieSearchError('Failed to fetch movie: $e');
      }
    }
  }


  Future<Movie> fetchMovie(String query) async {
    final apiKey = 'ee7cc67f';
    final url = 'http://www.omdbapi.com/?t=$query&apikey=$apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Movie.fromJson(data);
    } else {
      throw Exception('Failed to fetch movie');
    }
  }

}