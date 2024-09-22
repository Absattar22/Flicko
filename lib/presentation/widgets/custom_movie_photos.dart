import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class CustomMoviePhotos extends StatelessWidget {
  final List<String> imageUrls;

  const CustomMoviePhotos({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8, 
        childAspectRatio: 3 / 2,
      ),
      itemCount: imageUrls.length,
      shrinkWrap: true, // Take the minimum space required
      physics:
          const NeverScrollableScrollPhysics(), // Disable scrolling of the grid
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
