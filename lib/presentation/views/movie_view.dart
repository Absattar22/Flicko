import 'package:flicko/constants.dart';
import 'package:flicko/cubit/AddToWatchListCubit/add_to_watch_list_cubit_cubit.dart';
import 'package:flicko/data/api.dart';
import 'package:flicko/presentation/views/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_view.dart';
import 'home_view.dart';
import 'recommendation_view.dart';
import 'watch_list_view.dart';
import '../widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MovieView extends StatefulWidget {
  const MovieView({super.key});

  static const String id = 'movieView';

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  int currentIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const WatchListView(),
    const RecommendationView(),
    const CategoriesView(
    ),
    const ProfileView(),
  ];

  final List<IconData> iconList = [
    Icons.home,
    Icons.bookmark,
    Icons.recommend,
    Icons.category_outlined,
    Icons.person,
  ];

  final List<String> labels = [
    'Home',
    'Watchlist',
    'Recommend',
    'Categories',
    'Profile',
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: BlocProvider(
        create: (context) => AddToWatchListCubit(apiService: ApiService()),
        child: IndexedStack(
          index: currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTabTapped: onTabTapped,
        iconList: iconList,
        labels: labels,
      ),
    );
  }
}
