import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
import 'sign_in_view.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static String id = 'forgotPassword';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignInView()),
                (route) => false);
          },
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      backgroundColor: kPrimaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'An email will be sent to reset your password',
              style: TextStyle(
                color: Color.fromARGB(255, 180, 179, 179),
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: email,
              style: const TextStyle(
                color: Color.fromARGB(255, 161, 154, 154),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Email',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 147, 145, 145),
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 30, 30, 30),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),

          // Reset Button
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kSecondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 10,
                ),
              ),
              onPressed: () async {
                try {
                  await ResetEmail();

                  if (email.text.trim().isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password reset email sent'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter your email'),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error sending password reset email'),
                    ),
                  );
                }
              },
              child: const Text(
                'Reset Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future ResetEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.text.trim());
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const SignInView()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      return false;
    }
  }
}
