import 'package:flicko/constants.dart';
import 'package:flicko/views/intro_views.dart';
import 'package:flicko/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({super.key});

  static const String id = 'onBoardingScreen';
  final List<dynamic> introScreens = [
    {
      'title': 'Welcome to Flicko',
      'description':
          'Discover your next favorite film. Flicko uses personalized recommendations to find movies that match your taste',
      'img': 'assets/images/intro1.svg',
    },
    {
      'title': 'Trending Now',
      'description':
          'Stay up-to-date with the latest box office hits and popular streaming choices',
      'img': 'assets/images/intro2.svg',
    },
    {
      'title': 'All-Time Favorites',
      'description':
          'Rediscover cinematic masterpieces and timeless classics that have stood the test of time',
      'img': 'assets/images/intro3.svg',
    },
    {
      'title': 'Connect and Share',
      'description':
          'Share your movie recommendations with friends and family, and discover new gems together',
      'img': 'assets/images/intro4.svg',
    },
  ];

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  String _buttonText = 'Next';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        // Update the button text based on the current page
        if (_controller.page == 3) {
          _buttonText = 'Get Started';
        } else {
          _buttonText = 'Next';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: [
              for (var screen in widget.introScreens)
                IntroScreens(
                  title: screen['title'],
                  description: screen['description'],
                  img: screen['img'],
                ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ElevatedButton(
                onPressed: () async {
                  if (_controller.page == 3) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('onboarding', true);

                    if (!mounted) return;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInView()));
                  } else {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 75),
                        curve: Curves.fastEaseInToSlowEaseOut);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(20, 45),
                  backgroundColor: const Color(0xFFD61919),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _buttonText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SmoothPageIndicator(
                  onDotClicked: (index) => _controller.animateToPage(index,
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInCirc),
                  controller: _controller,
                  count: 4,
                  effect: const WormEffect(
                    activeDotColor: Color(0xFFD61919),
                    dotColor: Color.fromARGB(255, 255, 255, 255),
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
