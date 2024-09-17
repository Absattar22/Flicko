import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'custom_cached_network_image.dart';

class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> movieNames = [
      'Interstellar',
      'All The Bright Places',
      'Furious 7',
      'Harry Potter',
      'Inception',
      'Spider-Man',
      'Inside Out 2',
      'The Green Mile',
      'The Shawshank Redemption',
      'The Dark Knight',
    ];

    List<Widget> images = const [
      CustomCachedNetworkImage(
        imageUrl:
            'https://resizing.flixster.com/7c3qnZfPzZgID7Ft97PccFwEf9U=/206x305/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p10543523_p_v8_as.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://media0055.elcinema.com/uploads/_640x_bcf9571c922b28fbebcab91266dfbc78738fc58f479dd1768dd69b125cad34bd.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://musicimage.xboxlive.com/catalog/video.movie.8D6KGWXN8J3V/image?locale=en-ca&mode=crop&purposes=BoxArt&q=90&h=300&w=200&format=jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BZjhkNjM0ZTMtNGM5MC00ZTQ3LTk3YmYtZTkzYzdiNWE0ZTA2XkEyXkFqcGc@._V1_.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BZjI5NmFmOWUtZWY0ZS00NTc5LWE0YjgtMjk3YmNiM2EwM2U4XkEyXkFqcGdeQXVyMTA1NjE5MTAz._V1_.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BYTc1MDQ3NjAtOWEzMi00YzE1LWI2OWUtNjQ0OWJkMzI3MDhmXkEyXkFqcGdeQXVyMDM2NDM2MQ@@._V1_.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BMTUxMzQyNjA5MF5BMl5BanBnXkFtZTYwOTU2NTY3._V1_FMjpg_UX1000_.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/M/MV5BNDE3ODcxYzMtY2YzZC00NmNlLWJiNDMtZDViZWM2MzIxZDYwXkEyXkFqcGdeQXVyNjAwNDUxODI@._V1_.jpg',
      ),
      CustomCachedNetworkImage(
        imageUrl:
            'https://m.media-amazon.com/images/S/pv-target-images/e9a43e647b2ca70e75a3c0af046c4dfdcd712380889779cbdc2c57d94ab63902.jpg',
      ),
    ];

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const SizedBox(height: 20),
        // "Now Showing" Text at the Top
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
                  color: Colors.black.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Carousel Slider
        SizedBox(
          height: screenHeight * 0.4,
          width: screenWidth,
          child: CarouselSlider.builder(
            itemCount: movieNames.length,
            itemBuilder: (context, index, realIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      // Movie Image
                      SizedBox(
                        height: screenHeight * 0.35,
                        width: screenWidth * 0.7,
                        child: images[index],
                      ),
                      // Gradient Overlay to ensure text is visible
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
                        bottom: 15,
                        left: 15,
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle_filled,
                              color: Colors.white,
                              size: screenWidth * 0.07,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              movieNames[index],
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(2, 2),
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.6),
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
              );
            },
            options: CarouselOptions(
              initialPage: 0,
              height: screenHeight * 0.35,
              viewportFraction: screenWidth > 600 ? 0.35 : 0.55,
              pageSnapping: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayCurve: Curves.easeInOut,
              autoPlayAnimationDuration: const Duration(milliseconds: 900),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
      ],
    );
  }
}
