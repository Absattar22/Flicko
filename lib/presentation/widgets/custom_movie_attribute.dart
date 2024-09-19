import 'package:flutter/material.dart';

class CustomMovieAttribute extends StatelessWidget {
  final String title;
  final String value;

  const CustomMovieAttribute({required this.title, required this.value, super.key});
     
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}