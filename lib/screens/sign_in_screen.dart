import 'package:animations/animations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/sign_up_screen.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/google_sign_in_button.dart';
import 'package:notes_app/widgets/text_field.dart';

import 'user_info_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

Route _routeToSignUpScreen() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => SignUpScreen(),
    transitionDuration: Duration(milliseconds:500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      );
    },
  );
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                    SizedBox(height: 25),
                    Text(
                      'Quote Note',
                      style: TextStyle(
                        color: CustomColors.darkGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction, 
                      key: _formKey,
                      child: Column(
                        children: [
                          NeumorphicTextField(
                            labelText: 'Email',
                            icon: Icon(Icons.email),
                            controller: _emailController,
                          ),
                          SizedBox(height: 10),
                          NeumorphicTextField(
                            labelText: 'Password',
                            icon: Icon(Icons.lock_rounded),
                            password: true,
                            controller: _passwordController,
                          ),
                          Button(
                            text: 'Log in',
                            color: CustomColors.primary,
                            textColor: CustomColors.white,
                            onPressed: () async {
                              User? user;

                              if (_formKey.currentState!.validate()) {
                                user = await Authentication.signInWithEmail(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }

                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => UserInfoScreen(
                                      user: user!,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Button(
                            text: "Don't have an account? Sign up!",
                            color: CustomColors.white,
                            textColor: CustomColors.darkGrey,
                            onPressed: () => {
                              Navigator.of(context)
                                  .pushReplacement(_routeToSignUpScreen())
                            },
                          ),
                        ],
                      ),
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
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
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
