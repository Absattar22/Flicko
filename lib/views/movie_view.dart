import 'package:firebase_auth/firebase_auth.dart';
import 'package:flicko/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key});

  static const String id = 'movieView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie View'),
      ),
      body: Center(
        child: IconButton(
          onPressed: () async {
            GoogleSignIn googleSignIn = GoogleSignIn();
            await googleSignIn.signOut();
            await FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
              SignUpView.id,
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
