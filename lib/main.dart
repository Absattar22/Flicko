import 'package:firebase_core/firebase_core.dart';
import 'package:flicko/presentation/views/categories_view.dart';
import 'package:flicko/presentation/views/forgot_password_view.dart';
import 'package:flicko/presentation/views/movie_details_view.dart';
import 'package:flicko/presentation/views/movie_view.dart';
import 'package:flicko/presentation/views/onboarding_screen.dart';
import 'package:flicko/presentation/views/profile_view.dart';
import 'package:flicko/presentation/views/recommendation_view.dart';
import 'package:flicko/presentation/views/sign_in_view.dart';
import 'package:flicko/presentation/views/sign_up_view.dart';
import 'package:flicko/presentation/views/view_all_view.dart';
import 'package:flicko/presentation/views/watch_list_view.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => Flicko(initialRoute: initialRoute),
  ));
}

class Flicko extends StatelessWidget {
  final String initialRoute;
  const Flicko({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        MovieView.id: (context) => const MovieView(),
        SignInView.id: (context) => const SignInView(),
        SignUpView.id: (context) => const SignUpView(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        MovieDetailsView.id: (context) => const MovieDetailsView(),
        ViewAllView.id: (context) => const ViewAllView(),
        CategoriesView.id: (context) => const CategoriesView(),
        RecommendationView.id: (context) => const RecommendationView(),
        ProfileView.id: (context) => const ProfileView(),
        WatchListView.id: (context) => const WatchListView(),
      },
      initialRoute: initialRoute,
    );
  }
}
