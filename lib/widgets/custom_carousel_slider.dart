import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
      'Movie 7',
      'Movie 8',
      'Movie 9',
      'Movie 10',
    ];

    List<Image> images = [
      Image.network(
          'https://resizing.flixster.com/7c3qnZfPzZgID7Ft97PccFwEf9U=/206x305/v2/https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p10543523_p_v8_as.jpg'),
      Image.network(
          'https://m.media-amazon.com/images/M/MV5BOWVhYzY1ODItOTU0Ni00MDQwLTk3ZDYtOTc0YTAwMmM4NzAxXkEyXkFqcGc@._V1_.jpg'),
      Image.network(
          'https://media0055.elcinema.com/uploads/_640x_bcf9571c922b28fbebcab91266dfbc78738fc58f479dd1768dd69b125cad34bd.jpg'),
      Image.network(
          'https://musicimage.xboxlive.com/catalog/video.movie.8D6KGWXN8J3V/image?locale=en-ca&mode=crop&purposes=BoxArt&q=90&h=300&w=200&format=jpg'),
      Image.network(
          'https://m.media-amazon.com/images/M/MV5BZjhkNjM0ZTMtNGM5MC00ZTQ3LTk3YmYtZTkzYzdiNWE0ZTA2XkEyXkFqcGc@._V1_.jpg'),
      Image.network('https://picsum.photos/seed/5/200/300'),
      Image.network('https://picsum.photos/seed/6/200/300'),
      Image.network('https://picsum.photos/seed/7/200/300'),
      Image.network('https://picsum.photos/seed/8/200/300'),
      Image.network('https://picsum.photos/seed/9/200/300'),
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
          child: CarouselSlider.builder(
            itemCount: movieNames.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      // Movie Image
                      images[index],
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
                      // Movie Title and Icon at the bottom
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Row(
                          children: [
                            Icon(
                              Icons.play_circle_filled,
                              color: Colors.white,
                              size: screenWidth * 0.07, // Scaled to screen size
                            ),
                            const SizedBox(width: 8),
                            Text(
                              maxLines: 2,
                              movieNames[index],
                              style: TextStyle(
                                fontSize:
                                    screenWidth * 0.030, // Responsive font size
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
              initialPage: 1,
              height: screenHeight * 0.35,
              viewportFraction: screenWidth > 600 ? 0.3 : 0.6,
              pageSnapping: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: false,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
            ),
          ),
        ),
      ],
    );
  }
}
