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

  MoviesProvider() {
    getMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(_baseAddress, endPoint,
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

  void getCreditsMovie(int id) async {
    final jsonData = await _getJsonData('3/movie/$id/credits', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }
}
