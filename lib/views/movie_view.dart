import 'package:flicko/views/categories_view.dart';
import 'package:flicko/views/home_view.dart';
import 'package:flicko/views/recommendation_view.dart';
import 'package:flicko/views/search_view.dart';
import 'package:flicko/views/watch_list_view.dart';
import 'package:flicko/widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flicko/constants.dart';


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
    const SearchView(),
    const CategoriesView(),
  ];

  final List<IconData> iconList = [
    Icons.home,
    Icons.bookmark,
    Icons.recommend,
    Icons.search,
    Icons.category_outlined,
  ];

  final List<String> labels = [
    'Home',
    'Watchlist',
    'Recommend',
    'Search',
    'Categories',
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
      body: IndexedStack(
        index:
            currentIndex, 
        children: _screens,
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
