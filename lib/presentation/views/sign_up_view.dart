import 'package:firebase_auth/firebase_auth.dart';
import 'package:flicko/constants.dart';
import 'movie_view.dart';
import 'sign_in_view.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/other_sign_in_options.dart';
import '../widgets/sign_in_with_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpView extends StatefulWidget {
  static String id = 'signUpView';

  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
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
                      'assets/images/sign_up.svg',
                      height: screenHeight * 0.22,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Welcome To Flicko',
                      style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: screenHeight * 0.03,
                        fontFamily: 'figtree',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Sign Up To Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenHeight * 0.022,
                        fontFamily: 'figtree',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    CustomFormTextField(
                      onChanged: (value) {
                        email = value;
                      },
                      hint: 'Enter Your Email',
                      obscureText: false,
                      text: 'Email',
                      isSignup: true,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    CustomFormTextField(
                      onChanged: (value) {
                        password = value;
                      },
                      hint: 'Enter Your Password',
                      obscureText: isObscured,
                      text: 'Password',
                      isSignup: true,
                    ),
                    SizedBox(height: screenHeight * 0.04),
                    CustomButton(
                      text: 'Sign Up',
                      color1: kSecondaryColor,
                      color2: kSecondaryColor,
                      txtColor: Colors.white,
                      borderColor: Colors.black,
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await SignUpNewUser();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                MovieView.id, (route) => false);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ShowSnackBar(
                                  context,
                                  'The password provided is too weak.',
                                  Colors.redAccent,
                                  Icons.error);
                            } else if (e.code == 'email-already-in-use') {
                              ShowSnackBar(
                                  context,
                                  'The account already exists.',
                                  Colors.blueAccent,
                                  Icons.email);
                            } else {
                              ShowSnackBar(
                                  context,
                                  'An error occurred. Please try again.',
                                  Colors.red,
                                  Icons.error);
                            }
                          } finally {
                            setState(() {
                              isLoading = false;
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
                      text: 'Sign in with Google',
                      img: 'assets/images/google.png',
                      onTap: () async {
                        setState(() {
                          isLoading = true;
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
                            isLoading = false;
                          });
                        }
                      },
                    ),
                    SizedBox(height: screenHeight * 0.002),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have An Account?',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 173, 169, 169),
                            fontSize: screenHeight * 0.018,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                SignInView.id, (route) => false);
                          },
                          child: Text(
                            'Sign In',
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
      ),
    );
  }

  Future<UserCredential> SignUpNewUser() async {
    return await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
