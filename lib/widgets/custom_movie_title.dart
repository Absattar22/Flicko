import 'custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomMovieTitle extends StatefulWidget {
  const CustomMovieTitle({super.key});

  @override
  State<CustomMovieTitle> createState() => _CustomMovieTitleState();
}

class _CustomMovieTitleState extends State<CustomMovieTitle> {
  bool isWatchLater = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Interstellar',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isWatchLater = !isWatchLater;
                  });
                },
                icon: FaIcon(FontAwesomeIcons.solidBookmark,
                    color: isWatchLater
                        ? const Color.fromARGB(255, 227, 166, 12)
                        : Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.yellow.shade700,
              ),
              const SizedBox(width: 2),
              Text(
                '10 /10 IMDb',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              CustomElevatedButton(title: 'Sci-Fi'),
              SizedBox(width: 10),
              CustomElevatedButton(title: 'Adventure'),
              SizedBox(width: 10),
              CustomElevatedButton(title: 'Drama'),
            ],
          ),
        ],
      ),
    );
  }
}
