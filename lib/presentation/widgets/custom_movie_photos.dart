import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class CustomMoviePhotos extends StatelessWidget {
  final List<String> imageUrls;

  const CustomMoviePhotos({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenHeight > 900 ? 4 : 4,
        crossAxisSpacing: screenWidth > 700 ? 12 : 6,
        mainAxisSpacing: screenHeight > 900 ? 12 : 6,
        childAspectRatio: 1.3,
      ),
      itemCount: imageUrls.length,
      shrinkWrap: true, // Take the minimum space required
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              fit: BoxFit.fill,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(
                  color: kSecondaryColor,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
