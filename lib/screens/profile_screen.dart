import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/group_screen.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/utils/profile.dart';
import 'package:notes_app/widgets/app_bars/app_bar_profile.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';

String tempURL = '';
bool isSaving = false;
bool isUpdating = false;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _user = widget._user;

    if (_user.photoURL != null) {
      tempURL = _user.photoURL!;
    }

    super.initState();
  }

  Future<String> uploadToFirebase(File file) async {
    setState(() {
      isUpdating = true;
    });

    String returnResult =
        await Profile.uploadToFirebase(context, file, 'profile_pictures');

    setState(() {
      isUpdating = false;
    });
    return returnResult;
  }

  Future<void> toggleNightMode(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    var isDarkMode = NeumorphicTheme.of(context)!.isUsingDark;

    isDarkMode = !isDarkMode;
    NeumorphicTheme.of(context)!.themeMode =
        isDarkMode ? ThemeMode.dark : ThemeMode.light;
    prefs.setBool('darkMode', isDarkMode);
  }

  void saveProfile(
      {required BuildContext context,
      String email = '',
      String name = ''}) async {
    setState(() {
      isSaving = true;
    });

    //await Profile.saveProfile(email, name, tempURL, _user);

    if (email != '') {
      await _user.updateEmail(email).then((value) => _user.reload());
    }

    if (name != '') {
      await _user.updateProfile(displayName: name);
    }

    await _user.updateProfile(photoURL: tempURL).then((value) async {
      await _user
          .reload()
          .then((value) => {imageCache!.clear()})
          .then((value) => {imageCache!.clearLiveImages()})
          .then((value) => {_user = FirebaseAuth.instance.currentUser!});
    });

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference users = db.collection('users');

    users.doc(_user.uid).set({'display_name': _user.displayName});

    ScaffoldMessenger.of(context).showSnackBar(
      Authentication.customFeedbackSnackBar(
        content: 'Saved profile',
      ),
    );

    _emailController.clear();
    _nameController.clear();

    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.baseColor,
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          onPressed: () async {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => GroupScreen(
                  user: _user,
                  key: widget.key,
                ),
              ),
            );
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.arrow_back,
              color: theme.disabledColor,
            ),
          ),
        ),
      ]),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          brightness: NeumorphicTheme.of(context)!.themeMode == ThemeMode.light
              ? Brightness.light
              : Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: AppBarProfile(
            user: _user,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Neumorphic(
                padding: const EdgeInsets.all(0),
                style: NeumorphicStyle(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
                  depth: 3,
                  intensity: 1,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: theme.disabledColor),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 240,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: theme.baseColor),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ProfileTopHalf(theme: theme, parent: this),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  NeumorphicTextField(
                                    labelText: 'Name',
                                    icon: Icon(Icons.person_rounded,
                                        color: theme.variantColor),
                                    controller: _nameController,
                                  ),
                                  SizedBox(height: 10),
                                  NeumorphicTextField(
                                    labelText: 'Email',
                                    icon: Icon(Icons.email,
                                        color: theme.variantColor),
                                    controller: _emailController,
                                  ),
                                  Button(
                                      text: 'Change Password',
                                      color: theme.baseColor,
                                      textColor: theme.defaultTextColor,
                                      onPressed: () async {
                                        Profile.resetPassword(
                                            context: context,
                                            emailAddress: widget._user.email);
                                      }),
                                  !isSaving
                                      ? Button(
                                          text: 'Save',
                                          color: theme.disabledColor,
                                          textColor: CustomColors.bg,
                                          onPressed: () async {
                                            User? user;

                                            saveProfile(
                                                context: context,
                                                email:
                                                    _emailController.value.text,
                                                name:
                                                    _nameController.value.text);

                                            if (user != null) {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      GroupScreen(
                                                    user: user,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        )
                                      : CircularProgressIndicator(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTopHalf extends StatelessWidget {
  const ProfileTopHalf({
    Key? key,
    required this.theme,
    required this.parent,
  }) : super(key: key);

  final _ProfileScreenState parent;
  final NeumorphicThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        NeumorphicButton(
          onPressed: () {
            parent.toggleNightMode(context);
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(10),
          child: ClipOval(
            child: Icon(
              Icons.brightness_medium,
              color: theme.defaultTextColor,
              size: 25,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Neumorphic(
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            width: 100,
            height: 100,
            child: !isUpdating
                ? ClipOval(
                    child: tempURL != ''
                        ? Image.network(
                            tempURL,
                            key: UniqueKey(),
                            scale: 1,
                            fit: BoxFit.fitWidth,
                          )
                        : Icon(
                            Icons.person,
                            color:
                                theme.defaultTextColor,
                            size: 100,
                          ),
                  )
                : CircularProgressIndicator(),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        // File picker
        NeumorphicButton(
          onPressed: () async {
            File? profilePic = await Profile.pickFile();
            if (profilePic != null) {
              String _photoURL =
                  await parent.uploadToFirebase(profilePic);
              parent.setState(() {
                tempURL = _photoURL;
              });
            }
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(10),
          child: ClipOval(
            child: Icon(
              Icons.edit,
              color: theme.defaultTextColor,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }
}
