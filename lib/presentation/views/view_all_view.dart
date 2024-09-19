import 'package:flutter/material.dart';

class ViewAllView extends StatelessWidget {
  const ViewAllView({super.key});
  static const String id = 'viewAllView';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Image.asset('assets/images/actor1.jpg'),
              const SizedBox(height: 5),
              Text(
                'Movie ${index + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
