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

    return AnimatedBottomNavigationBar.builder(
      itemCount: iconList.length,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? Colors.red : Colors.grey;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconList[index],
              size: screenWidth * 0.06,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              labels[index],
              style: TextStyle(
                color: color,
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
      backgroundColor: kPrimaryColor,
      activeIndex: currentIndex,
      gapLocation: GapLocation.none, // No gap needed as we don't have a FAB
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: onTabTapped,
    );
  }
}
