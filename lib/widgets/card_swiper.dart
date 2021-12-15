import 'package:filmsapp/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:card_swiper/card_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
          itemCount: movies.length,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (context, index) {
            final movie = movies[index];

            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: 'cards'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: FadeInImage(
                    placeholder: const AssetImage('assets/no-image.jpg'),
                    image: NetworkImage(movie.fullPathImage),
                    fit: BoxFit.cover),
              ),
            );
          }),
    );
  }
}
