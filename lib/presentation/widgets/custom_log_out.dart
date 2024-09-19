import 'package:firebase_auth/firebase_auth.dart';
import 'package:flicko/presentation/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomLogOut extends StatelessWidget {
  const CustomLogOut({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
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
    );
  }
}
