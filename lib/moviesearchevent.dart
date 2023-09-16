abstract class MovieSearchEvent {}

class FetchMovie extends MovieSearchEvent {
  final String query;

  FetchMovie(this.query);
}

