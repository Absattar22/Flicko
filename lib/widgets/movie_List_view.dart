import 'package:flutter/material.dart';
import 'package:flicko/widgets/custom_now_showing.dart';

class MovieList extends StatelessWidget {
  const MovieList({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const CustomMovieViewBuilder(
                title: 'Popular',
                img: 'assets/images/Interstellar.jpg',
                movieTitle: 'Interstellar',
              ),
              const CustomMovieViewBuilder(
                title: 'Top Rated',
                img: 'assets/images/AllTheBrightPlaces.jpg',
                movieTitle: 'All The Bright Places',
              ),
              const CustomMovieViewBuilder(
                title: 'Must Watch',
                img: 'assets/images/furious7.jpg',
                movieTitle: 'Furious 7',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
