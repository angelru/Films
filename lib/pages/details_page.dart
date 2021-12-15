import 'package:filmsapp/models/models.dart';
import 'package:filmsapp/widgets/casting_cards.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie: movie),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterMovie(movie: movie),
            _OverView(movie: movie),
            const CastingCards()
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;

  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.cyan,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(movie.title,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center),
        ),
        background: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.fullBackdropPath!),
            fit: BoxFit.cover),
      ),
    );
  }
}

class _PosterMovie extends StatelessWidget {
  final Movie movie;

  const _PosterMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPathImage),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title,
                  style: textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2),
              Text(movie.originalTitle,
                  style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(movie.voteAverage.toString(), style: textTheme.caption)
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  final Movie movie;

  const _OverView({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1),
    );
  }
}
