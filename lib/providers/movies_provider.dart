import 'package:filmsapp/models/models.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final String _baseAddress = 'api.themoviedb.org';
  final String _apiKey = 'a5ca2b036a51f332ca1bdb3745fd6e67';
  final String _language = 'es-ES';

  MoviesProvider() {
    displayMovies();
  }

  displayMovies() async {
    var url = Uri.https(_baseAddress, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language, 'page': '1'});

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    print(nowPlayingResponse.results[0].title);
  }
}