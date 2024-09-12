import 'package:flutter/material.dart';
import 'package:flicko/widgets/custom_app_bar.dart';

class MovieViewAppBar extends StatelessWidget {
  const MovieViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      elevation: 0,
      pinned: false,
      floating: true,
      snap: true,
      expandedHeight: screenHeight * 0.01,
      flexibleSpace: const FlexibleSpaceBar(
        centerTitle: true,
        background: CustomAppBar(),
      ),
    );
  }
}
