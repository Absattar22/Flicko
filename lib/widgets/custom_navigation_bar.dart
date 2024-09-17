import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import '../constants.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabTapped;
  final List<IconData> iconList;
  final List<String> labels;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTabTapped,
    required this.iconList,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBottomNavigationBar.builder(
      height: screenHeight > 1100 ? 140 : 55,
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.red : Colors.grey;
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight > 1200 ? 20 : 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  iconList[index],
                  size: screenHeight * 0.027,
                  color: color,
                ),
                Text(
                  labels[index],
                  style: TextStyle(
                    color: color,
                    fontSize: screenWidth * 0.027,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
      backgroundColor: kPrimaryColor,
      activeIndex: currentIndex,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      onTap: onTabTapped,
    );
  }
}
