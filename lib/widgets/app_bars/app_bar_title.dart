import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarTitle extends StatefulWidget {
  final User? user;

  const AppBarTitle({required this.user});

  @override
  _AppBarTitleState createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
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
      ],
    );
  }
}
