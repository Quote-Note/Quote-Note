import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/group_screen.dart';

class Authentication {
  static SnackBar customErrorSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.red[700],
      content: Text(
        content,
        style: TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }

  static SnackBar customFeedbackSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: CustomColors.primary,
      content: Text(
        content,
        style: TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }

  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => GroupScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: 'The account already exists with a different credential',
            ),
          );
        } else if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: 'Error occurred while accessing credentials. Try again.',
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customErrorSnackBar(
            content: 'Error occurred using Google Sign In. Try again.',
          ),
        );
      }
    }

    return user;
  }

  static Future<User?> signUpWithEmail({required BuildContext context, email, password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: 'The password provided is too weak.',
            ),
          );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: 'The account already exists for that email.',
            ),
          );
      }
    }
    return user;
  }

  static Future<User> signInWithEmail({required BuildContext context, email, password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
              email: email,
              password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: 'No user found for that email.',
            ),
          );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: 'Wrong password provided for that user.',
            ),
          );
      }
    }
    return user!;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customErrorSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }
}
