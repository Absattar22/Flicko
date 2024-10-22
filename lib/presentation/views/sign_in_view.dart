import 'package:firebase_auth/firebase_auth.dart';
import 'package:flicko/constants.dart';
import 'forgot_password_view.dart';
import 'movie_view.dart';
import 'sign_up_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/other_sign_in_options.dart';
import '../widgets/sign_in_with_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInView extends StatefulWidget {
  static String id = 'signInView';

  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  bool isLoading = false;
  bool isGoogleLoading = false;
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.001),
                  SvgPicture.asset(
                    'assets/images/sign_in.svg',
                    height: screenHeight * 0.22,
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: screenHeight * 0.03,
                      fontFamily: 'Emad',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Please Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenHeight * 0.022,
                      fontFamily: 'Emad',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomFormTextField(
                    onChanged: (value) {
                      email = value;
                    },
                    hint: 'Enter Your Email',
                    obscureText: false,
                    text: 'Email',
                    isSignup: false,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  CustomFormTextField(
                    onChanged: (value) {
                      password = value;
                    },
                    hint: 'Enter Your Password',
                    obscureText: isObscured,
                    text: 'Password',
                    isSignup: false,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgotPassword.id);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 173, 169, 169),
                          fontSize: screenHeight * 0.018,
                          fontFamily: 'figtree',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  CustomButton(
                    text: 'Sign In',
                    color1: kSecondaryColor,
                    color2: kSecondaryColor,
                    txtColor: Colors.white,
                    borderColor: Colors.black,
                    isLoading: isLoading, // Pass loading state
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true; // Start loading
                        });
                        try {
                          final credential = await SignInUser();
                          if (credential != null) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MovieView.id, (route) => false);
                          } else {
                            ShowSnackBar(context, 'Sign in failed.', Colors.red,
                                Icons.error);
                          }
                        } on FirebaseAuthException catch (e) {
                          String message;
                          if (e.code == 'user-not-found') {
                            message = 'No user found for that email.';
                          } else if (e.code == 'wrong-password') {
                            message = 'Invalid login credentials.';
                          } else {
                            message = 'An error occurred. Please try again.';
                          }
                          ShowSnackBar(
                              context, message, Colors.red, Icons.error);
                        } finally {
                          setState(() {
                            isLoading = false; // Stop loading
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03),
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.03),
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  OtherSignInOptions(
                    txtColor: const Color.fromARGB(255, 30, 30, 30),
                    borderColor: const Color.fromARGB(255, 30, 30, 30),
                    text: 'Sign In With Google',
                    img: 'assets/images/google.png',
                    isGoogleLoading: isGoogleLoading,
                    onTap: () async {
                      setState(() {
                        isGoogleLoading = true; // Start loading
                      });
                      try {
                        await signInWithGoogle();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            MovieView.id, (route) => false);
                      } catch (e) {
                        ShowSnackBar(context, 'Sign in failed.', Colors.red,
                            Icons.error);
                      } finally {
                        setState(() {
                          isGoogleLoading = false; // Stop loading
                        });
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.002),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t Have An Account?',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 173, 169, 169),
                          fontSize: screenHeight * 0.018,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              SignUpView.id, (route) => false);
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenHeight * 0.018,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<UserCredential> SignInUser() async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
