import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/group_screen.dart';
import 'package:notes_app/utils/auth.dart';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.disabledColor),
            )
          : NeumorphicButton(
              style: NeumorphicStyle(
                color: theme.baseColor,
                depth: 3,
                intensity: 1,
                shape: NeumorphicShape.flat,
                boxShape:
                    NeumorphicBoxShape.circle(),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });
                User? user =
                    await Authentication.signInWithGoogle(context: context);

                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => GroupScreen(
                        user: user,
                      ),
                    ),
                  );
                }
              },
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/google_logo.png"),
                      height: 35.0,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
