import 'package:flicko/constants.dart';
import 'package:flicko/widgets/custom_app_bar.dart';
import 'package:flicko/widgets/custom_now_showing.dart';
import 'package:flutter/material.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  static const String id = 'movieView';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            forceElevated: false,
            pinned: false,
            floating: true,
            snap: true,
            expandedHeight: screenHeight * 0.01,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              background: CustomAppBar(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const CustomMovieViewBuilder(
                    title: 'Now Showing',
                    img: 'assets/images/Interstellar.jpg',
                    movieTitle: 'Interstellar'),
                const CustomMovieViewBuilder(
                  title: 'Top Rated',
                  img: 'assets/images/AllTheBrightPlaces.jpg',
                  movieTitle: 'All The Bright Places',
                ),
                const CustomMovieViewBuilder(
                  title: 'Top Watched',
                  img: 'assets/images/furious7.jpg',
                  movieTitle: 'Furious 7',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
