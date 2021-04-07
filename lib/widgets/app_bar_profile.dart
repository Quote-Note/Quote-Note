import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/profile_screen.dart';
import 'package:notes_app/screens/sign_in_screen.dart';
import 'package:notes_app/screens/user_info_screen.dart';
import 'package:notes_app/utils/auth.dart';

class AppBarProfile extends StatefulWidget {
  final User? user;

  const AppBarProfile(
      {required this.user});

  @override
  _AppBarProfileState createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile> {
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
    return Row(
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            depth: -1,
            intensity: 1,
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
                      fit: BoxFit.fitWidth,
                    )
                  : Icon(
                      Icons.person,
                      color: CustomColors.darkGrey,
                      size: 30,
                    ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                "Profile",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CustomColors.darkGrey,
                )),
          ),
        ),
        SizedBox(width: 10,),
        NeumorphicButton(
          onPressed: () async {
            Navigator.of(context).pushReplacement(_routeTo(UserInfoScreen(user: widget.user!)));
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Icon(
              Icons.arrow_back,
              color: CustomColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
