import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/sign_in_screen.dart';
import 'package:notes_app/screens/group_screen.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/google_sign_in_button.dart';
import 'package:notes_app/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.baseColor,
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
                        color: theme.defaultTextColor,
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
                            icon: Icon(Icons.email, color: theme.variantColor),
                            controller: _emailController,
                          ),
                          SizedBox(height: 10),
                          NeumorphicTextField(
                            labelText: 'Password',
                            icon: Icon(Icons.lock_rounded, color: theme.variantColor,),
                            password: true,
                            controller: _passwordController,
                          ),
                          Button(
                            text: 'Create account',
                            color: theme.disabledColor,
                            textColor: CustomColors.bg,
                            onPressed: () async {
                              User? user;

                              if (_formKey.currentState!.validate()) {
                                user = await Authentication.signUpWithEmail(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }

                              if (user != null) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => GroupScreen(
                                      user: user!,
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Button(
                            text: 'Already have an account? Log in!',
                            color: theme.baseColor,
                            textColor: theme.defaultTextColor,
                            onPressed: () => {
                              Navigator.of(context)
                                  .pushReplacement(Routes.routeTo(SignInScreen()))
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
                        theme.disabledColor,
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
