import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarProfile extends StatefulWidget {
  final User? user;

  const AppBarProfile({required this.user});

  @override
  _AppBarProfileState createState() => _AppBarProfileState();
}

class _AppBarProfileState extends State<AppBarProfile> {
  bool isAdmin = false;


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
                      color: theme.defaultTextColor,
                      size: 30,
                    ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text("Profile",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.defaultTextColor,
                )),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
