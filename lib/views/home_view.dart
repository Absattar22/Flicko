// home_view.dart
import 'package:flutter/material.dart';
import 'package:flicko/widgets/custom_app_bar.dart';
import 'package:flicko/widgets/custom_now_showing.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          elevation: 0,
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
