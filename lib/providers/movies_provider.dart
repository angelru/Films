import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:filmsapp/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseAddress = 'api.themoviedb.org';
  final String _apiKey = 'a5ca2b036a51f332ca1bdb3745fd6e67';
  final String _language = 'es-ES';

  List<Movie> movies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getMovies();
    getPopularMovies();
  }

  getMovies() async {
    var url = Uri.https(_baseAddress, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    movies = nowPlayingResponse.results;
    notifyListeners();
  }

  void getPopularMovies() async {
    var url = Uri.https(_baseAddress, '3/movie/popular',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);
    popularMovies = [...popularResponse.results];
    notifyListeners();
  }
}
