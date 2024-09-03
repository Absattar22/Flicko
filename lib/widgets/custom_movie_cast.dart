import 'package:flutter/material.dart';

class CustomMovieCast extends StatelessWidget {
  const CustomMovieCast({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Cast:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              int crossAxisCount = (screenWidth ~/ 200)
                  .clamp(4, 12); //min 4 avatar , max 12 avatar

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 12,
                itemBuilder: (context, index) {
                  // Calculate dynamic radius for CircleAvatar
                  double avatarRadius = screenWidth / (crossAxisCount * 2.8);

                  return Column(
                    children: [
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: AssetImage(
                          'assets/images/actor${index + 1}.jpg',
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Actor ${index + 1}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
