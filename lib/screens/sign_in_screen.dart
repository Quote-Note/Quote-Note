import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/sign_up_screen.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/google_sign_in_button.dart';
import 'package:notes_app/widgets/text_field.dart';

import 'group_screen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _forgotPasswordController = TextEditingController();
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
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            labelText: 'Email',
                            icon: Icon(Icons.email, color: theme.variantColor),
                            controller: _emailController,
                          ),
                          SizedBox(height: 10),
                          NeumorphicTextField(
                            keyboardType: TextInputType.visiblePassword,
                            maxLines: 1,
                            labelText: 'Password',
                            icon: Icon(
                              Icons.lock_rounded,
                              color: theme.variantColor,
                            ),
                            password: true,
                            controller: _passwordController,
                          ),
                          Button(
                            text: 'Log in',
                            color: theme.disabledColor,
                            textColor: CustomColors.bg,
                            onPressed: () async {
                              User? user;

                              if (_formKey.currentState!.validate()) {
                                user = await Authentication.signInWithEmail(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text);
                              }

                              if (user != null) {
                                Routes.routeTo(GroupScreen(
                                  user: user,
                                  key: widget.key,
                                ));
                              }
                            },
                          ),
                          Button(
                            text: "Don't have an account? Sign up!",
                            color: theme.baseColor,
                            textColor: theme.defaultTextColor,
                            onPressed: () => {
                              Navigator.of(context).pushReplacement(
                                  Routes.routeTo(SignUpScreen()))
                            },
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.transparent,
                                      titlePadding: const EdgeInsets.all(0.0),
                                      contentPadding: const EdgeInsets.all(8.0),
                                      content: Neumorphic(
                                        style: NeumorphicStyle(
                                          color: theme.baseColor,
                                          depth: 3,
                                          intensity: 1,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: SizedBox(
                                              width: 300,
                                              height: 250,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text('Enter your email',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 24)),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  NeumorphicTextField(
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    maxLines: 1,
                                                    labelText: 'Email',
                                                    icon: Icon(Icons.email,
                                                        color:
                                                            theme.variantColor),
                                                    controller:
                                                        _forgotPasswordController,
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Button(
                                                    text: "Reset password",
                                                    color: theme.baseColor,
                                                    textColor:
                                                        theme.defaultTextColor,
                                                    onPressed: () {
                                                      Authentication.forgotPassword(context: context, email: _forgotPasswordController.value.text);
                                                      _forgotPasswordController.clear();
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text('Forgot your password?',
                                  style: TextStyle(
                                    color: theme.disabledColor,
                                  )))
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
