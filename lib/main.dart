import 'package:firebase_core/firebase_core.dart';
import 'package:flicko/firebase_options.dart';
import 'package:flicko/views/categories_view.dart';
import 'package:flicko/views/forgot_password_view.dart';
import 'package:flicko/views/movie_details_view.dart';
import 'package:flicko/views/movie_view.dart';
import 'package:flicko/views/onboarding_screen.dart';
import 'package:flicko/views/recommendation_view.dart';
import 'package:flicko/views/sign_in_view.dart';
import 'package:flicko/views/sign_up_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flicko/views/view_all_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();
  final bool hasSeenOnboarding = prefs.getBool('onboarding') ?? false;
  final User? user = FirebaseAuth.instance.currentUser;

  String initialRoute;

  if (!hasSeenOnboarding) {
    initialRoute = OnBoardingScreen.id;
  } else if (user != null) {
    initialRoute = MovieView.id;
  } else {
    initialRoute = SignUpView.id;
  }

  runApp( Flicko(initialRoute: initialRoute),
  );
}

class Flicko extends StatelessWidget {
  final String initialRoute;
  const Flicko({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      //locale: DevicePreview.locale(context),
     // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        MovieView.id: (context) => const MovieView(),
        SignInView.id: (context) => const SignInView(),
        SignUpView.id: (context) => const SignUpView(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        MovieDetails.id: (context) => const MovieDetails(),
        ViewAllView.id: (context) => const ViewAllView(),
        CategoriesView.id: (context) => const CategoriesView(),
        RecommendationView.id: (context) => const RecommendationView(),
      },
      initialRoute: initialRoute,
    );
  }
}
