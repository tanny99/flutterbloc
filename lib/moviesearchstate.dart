import 'movie.dart';
abstract class MovieSearchState {}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final Movie movie;

  MovieSearchLoaded(this.movie);
}

class MovieSearchError extends MovieSearchState {
  final String error;

  MovieSearchError(this.error);
}