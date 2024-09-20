import 'package:flutter/material.dart';

class CustomMovieDescription extends StatelessWidget {
  const CustomMovieDescription({super.key , required this.description } ); 
 final String description;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
