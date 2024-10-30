import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flicko/constants.dart';
import 'package:flicko/presentation/views/movie_view.dart';
import 'package:flicko/presentation/views/onboarding_screen.dart';
import 'package:flicko/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String id = 'splash_screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeInAnimation;
  late Animation<double> scaleAnimation;

  String fullText = 'Your Movie Companion';
  String displayedText = '';
  int currentIndex = 0;
  Timer? typingTimer;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startTextTypingAnimation();
    navigateToNextScreen();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    animationController.forward();
  }

  void _startTextTypingAnimation() {
    typingTimer = Timer.periodic(const Duration(milliseconds: 80), (timer) {
      if (currentIndex < fullText.length) {
        if (mounted) {
          setState(() {
            displayedText += fullText[currentIndex];
            currentIndex++;
          });
        }
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('onboarding') ?? false;
    final User? user = FirebaseAuth.instance.currentUser;

    String nextRoute;
    if (!hasSeenOnboarding) {
      if (user != null) {
        await FirebaseAuth.instance.signOut();
      }
      nextRoute = OnBoardingScreen.id;
    } else if (user != null) {
      nextRoute = MovieView.id;
    } else {
      nextRoute = SignInView.id;
    }

    Navigator.pushReplacementNamed(context, nextRoute);
  }

  @override
  void dispose() {
    animationController.dispose();
    typingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: fadeInAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: SvgPicture.asset(
                  'assets/images/icon.svg',
                  height: 200,
                  width: 200,
                ),
              ),
            ),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.purple, Colors.blueAccent],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ).createShader(bounds),
              child: Text(
                displayedText,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
