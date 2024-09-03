import 'package:flicko/constants.dart';
import 'package:flicko/widgets/custom_movie_view.dart';
import 'package:flutter/material.dart';

class CustomMovieViewBuilder extends StatelessWidget {
  const CustomMovieViewBuilder(
      {super.key,
      required this.title,
      required this.img,
      required this.movieTitle});

  final String title, img, movieTitle;

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
                title,
                style: TextStyle(
                  fontSize: screenHeight * 0.02,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Emad',
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'viewAllView');
                    },
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
            height: screenHeight * 0.38,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'movieDetails');
                  },
                  child: CustomMovieView(
                    img: img,
                    title: movieTitle,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
