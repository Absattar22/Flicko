import 'package:flicko/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:flicko/presentation/widgets/custom_movie_builder.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final String title, img, movieTitle, rating;
  final int count;

  final void Function() onPressed;
  final void Function() onTap;

  const MovieList({
    super.key,
    required this.movies,
    required this.title,
    required this.img,
    required this.movieTitle,
    required this.rating,
    required this.count,
    required this.onPressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          movies.isEmpty
              ? const Center(child: Text('No movies available'))
              : SizedBox(
                  height: 200, // Adjust height as needed
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return CustomMovieViewBuilder(
                        title: title,
                        movies: movies,
                        onPressed: onPressed,
                        onTap: onTap,
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
