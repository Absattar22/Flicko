import 'package:cached_network_image/cached_network_image.dart';
import 'package:flicko/constants.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(color: kSecondaryColor),
      ),
    );
  }
}
