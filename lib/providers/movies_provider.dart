import 'package:filmsapp/models/search_movie_response.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:filmsapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseAddress = 'api.themoviedb.org';
  final String _apiKey = 'a5ca2b036a51f332ca1bdb3745fd6e67';
  final String _language = 'es-ES';

  List<Movie> movies = [];
  List<Movie> popularMovies = [];
  int _popularPage = 0;
  Map<int, List<Cast>> movieCast = {};

  MoviesProvider() {
    getMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    final url = Uri.https(_baseAddress, endPoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});

    final response = await http.get(url);
    return response.body;
  }

  void getMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    movies = nowPlayingResponse.results;
    notifyListeners();
  }

  void getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getCreditsMovie(int id) async {
    if (movieCast.containsKey(id)) {
      return movieCast[id]!;
    }

    final jsonData = await _getJsonData('3/movie/$id/credits', _popularPage);
    final creditResponse = CreditResponse.fromJson(jsonData);
    movieCast[id] = creditResponse.cast;
    return creditResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_baseAddress, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    final response = await http.get(url);
    final searchMovieResponse = SearchMovieResponse.fromJson(response.body);
    return searchMovieResponse.results;
  }
}
