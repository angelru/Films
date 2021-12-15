import 'package:flutter/material.dart';

import 'package:filmsapp/providers/movies_provider.dart';
import 'package:filmsapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas en cines'),
        elevation: 0,
        actions: [
          IconButton(
              icon: const Icon(Icons.search_outlined), onPressed: () => {}),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        CardSwiper(movies: movieProvider.movies),
        MoiveSlider(
          movies: movieProvider.popularMovies,
          title: "Populares",
          onNextPage: () => movieProvider.getPopularMovies(),
        ),
      ])),
    );
  }
}
