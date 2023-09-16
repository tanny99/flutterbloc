class Movie {
  final String title;
  final String imdbRating;
  final String genre;
  final String posterUrl;

  Movie({
    required this.title,
    required this.imdbRating,
    required this.genre,
    required this.posterUrl,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'],
      imdbRating: json['imdbRating'],
      genre: json['Genre'],
      posterUrl: json['Poster'],
    );
  }
}