import 'package:http/http.dart' as http;
import 'dart:convert';
import 'movie.dart';
class MovieRepository {
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