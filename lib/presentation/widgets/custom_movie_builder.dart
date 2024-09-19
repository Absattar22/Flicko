import 'package:flicko/constants.dart';
import 'package:flicko/presentation/views/movie_details_view.dart';
import 'package:flicko/presentation/views/view_all_view.dart';
import 'package:flicko/presentation/widgets/custom_movie_view.dart';
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
                      Navigator.pushNamed(context, ViewAllView.id);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(
                            color: kSecondaryColor.withAlpha(200),
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
                screenHeight > 900 ? screenHeight * 0.40 : screenHeight * 0.32,
            child: ListView.builder(
              padding: EdgeInsets.only(top: screenHeight * 0.01),
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MovieDetailsView.id);
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
