import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/profile_screen.dart';
import 'package:notes_app/screens/sign_in_screen.dart';
import 'package:notes_app/utils/auth.dart';

class AppBarTitle extends StatefulWidget {
  final User? user;

  const AppBarTitle({required this.user});

  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  bool isAdmin = false;

  Route _routeTo(Widget location) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => location,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  void toggleAdmin() {
    setState(() {
      isAdmin = !isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Row(
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            depth: -1,
            intensity: 1,
            color: theme.baseColor,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 40,
            width: 40,
                      child: ClipOval(
              child: widget.user!.photoURL != null
                  ? Image.network(
                      widget.user!.photoURL.toString(),
                      key: ValueKey(new Random().nextInt(100)),
                      fit: BoxFit.fitWidth,
                    )
                  : Icon(
                      Icons.person,
                      color: theme.defaultTextColor,
                      size: 30,
                    ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                (widget.user!.displayName != null
                    ? widget.user!.displayName
                    : widget.user!.email.toString().substring(
                        0, widget.user!.email.toString().indexOf('@')))!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.defaultTextColor,
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        NeumorphicButton(
          onPressed: toggleAdmin,
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: isAdmin
                ? Icon(Icons.star, color: Colors.yellow[400])
                : Icon(Icons.star_border_outlined,
                    color: theme.defaultTextColor),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        NeumorphicButton(
          onPressed: () => {
            Navigator.of(context)
                .pushReplacement(_routeTo(ProfileScreen(user: widget.user!)))
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Icon(
              Icons.edit,
              color: theme.defaultTextColor,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        NeumorphicButton(
          onPressed: () async {
            setState(() {});
            await Authentication.signOut(context: context);
            setState(() {});
            Navigator.of(context).pushReplacement(_routeTo(SignInScreen()));
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Icon(
              Icons.logout,
              color: CustomColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
