import 'package:filmsapp/models/models.dart';
import 'package:filmsapp/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
      future: movieProvider.getCreditsMovie(movieId),
      builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
        if (snapshot.hasData) {
          final casts = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
                itemCount: casts.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => _CastCard(actor: casts[index])),
          );
        }

        return const SizedBox(
          height: 180,
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(actor.fullProfilePath),
                  height: 140,
                  width: 100,
                  fit: BoxFit.cover)),
          const SizedBox(height: 5),
          Text(
            actor.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
