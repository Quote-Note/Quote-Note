import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/google_sign_in_button.dart';
import 'package:notes_app/widgets/text_field.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image(
                      image: AssetImage("assets/quote_note_logo.png"),
                      height: 50.0,
                    ),
                    SizedBox(height: 50),
                    Text(
                      'Quote Note',
                      style: TextStyle(
                        color: CustomColors.darkGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    Column(
                      children: [
                        NeumorphicTextField(
                          labelText: 'Username',
                          icon: Icon(Icons.person_outline_rounded),
                        ),
                        SizedBox(height: 10),
                        NeumorphicTextField(
                          labelText: 'Password',
                          icon: Icon(Icons.lock_rounded),
                          password: true,
                        ),
                        Button(
                          text: 'Create account',
                          color: CustomColors.primary,
                          textColor: CustomColors.white,
                          onPressed: () => {},
                        ),
                        Button(
                          text: 'Already have an account? Log in!',
                          color: CustomColors.white,
                          textColor: CustomColors.darkGrey,
                          onPressed: () => {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: FutureBuilder(
                  future: Authentication.initializeFirebase(context: context),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error initializing Firebase');
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      return GoogleSignInButton();
                    }
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        CustomColors.primary,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
