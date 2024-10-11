import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flicko/models/movie_model.dart';
import 'package:flicko/constants.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    super.key,
    required this.movies,
    required this.onTap,
  });

  final List<Movie> movies;
  final void Function(int movieId) onTap;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Now Showing',
            style: TextStyle(
              fontSize: screenHeight * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 2,
              shadows: [
                Shadow(
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                  color:
                      const Color.fromARGB(255, 26, 97, 183).withOpacity(0.8),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
          child: SizedBox(
            height: screenHeight * 0.4,
            width: screenWidth,
            child: CarouselSlider.builder(
              itemCount: widget.movies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = widget.movies[index];
                return GestureDetector(
                  onTap: () => widget.onTap(movie.id),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: screenHeight > 800
                                ? screenHeight * 0.5
                                : screenHeight * 0.6,
                            width: screenWidth > 600
                                ? screenWidth * 0.4
                                : screenWidth * 0.6,
                            child: CachedNetworkImage(
                              imageUrl: movie.fullImageUrl(),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      kSecondaryColor),
                                ),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.7),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: screenWidth * 0.06,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  movie.title,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        offset: const Offset(0, 4),
                                        blurRadius: 4,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.8),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                height: screenHeight > 900
                    ? screenHeight * 0.5
                    : screenHeight * 0.55,
                viewportFraction: screenWidth > 600 ? 0.5 : 0.7,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
