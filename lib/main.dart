import 'package:flicko/views/movie_view.dart';
import 'package:flicko/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final bool onboarding = prefs.getBool('onboarding') ?? false;
  runApp(Flicko(onboarding: onboarding));
}

class Flicko extends StatelessWidget {
  final bool onboarding;
  const Flicko({super.key, this.onboarding = false});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: onboarding ? const MovieView() : OnBoardingScreen(),
    );
  }
}
