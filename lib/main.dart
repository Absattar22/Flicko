import 'package:firebase_core/firebase_core.dart';
import 'package:flicko/presentation/views/categories_view.dart';
import 'package:flicko/presentation/views/forgot_password_view.dart';
import 'package:flicko/presentation/views/movie_view.dart';
import 'package:flicko/presentation/views/onboarding_screen.dart';
import 'package:flicko/presentation/views/profile_view.dart';
import 'package:flicko/presentation/views/recommendation_view.dart';
import 'package:flicko/presentation/views/sign_in_view.dart';
import 'package:flicko/presentation/views/sign_up_view.dart';
import 'package:flicko/presentation/views/splash_screen.dart';
import 'package:flicko/presentation/views/watch_list_view.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const Flicko(),
  ));
}

class Flicko extends StatelessWidget {
  const Flicko({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routes: {
        SplashScreen.id: (context) => const SplashScreen(),
        OnBoardingScreen.id: (context) => OnBoardingScreen(),
        MovieView.id: (context) => const MovieView(),
        SignInView.id: (context) => const SignInView(),
        SignUpView.id: (context) => const SignUpView(),
        ForgotPassword.id: (context) => const ForgotPassword(),
        CategoriesView.id: (context) => const CategoriesView(),
        RecommendationView.id: (context) => const RecommendationView(),
        ProfileView.id: (context) => const ProfileView(),
        WatchListView.id: (context) => const WatchListView(),
      },
      initialRoute: SplashScreen.id,
    );
  }
}
