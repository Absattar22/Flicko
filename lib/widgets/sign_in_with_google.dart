import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  if (googleUser == null) {
    throw FirebaseAuthException(
      message: 'Sign in aborted by user',
      code: 'ERROR_ABORTED_BY_USER',
    );
  }

  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

  User? user = userCredential.user;
  String? displayName = user?.displayName;
  String? photoURL = user?.photoURL;

  return userCredential;
}
