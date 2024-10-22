import 'package:flicko/constants.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:flicko/presentation/widgets/custom_movie_view.dart';
import 'package:flutter/material.dart';

class CustomMovieViewBuilder extends StatefulWidget {
  const CustomMovieViewBuilder({
    super.key,
    required this.title,
    required this.movies,
    required this.onPressed,
    required this.onTap,
  });

  final String title;

  final List<Movie> movies;
  final void Function()? onPressed;
  final void Function(int movieId)? onTap;
  @override
  State<CustomMovieViewBuilder> createState() => _CustomMovieViewBuilderState();
}

class _CustomMovieViewBuilderState extends State<CustomMovieViewBuilder> {
  @override
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Emad',
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: widget.onPressed,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: screenHeight * 0.018,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: kSecondaryColor,
                            size: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height:
                  screenHeight > 900 ? screenHeight * 0.5 : screenHeight * 0.41,
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.only(top: screenHeight * 0.01),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: widget.movies.length,
                itemBuilder: (context, index) {
                  final movie = widget.movies[index];
                  return GestureDetector(
                    onTap: () => widget.onTap!(movie.id),
                    child: CustomMovieView(
                      img: movie.fullImageUrl(),
                      title: movie.title,
                      rating: movie.rating.toStringAsFixed(1),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
