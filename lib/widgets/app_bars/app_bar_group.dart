import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/user_info_screen.dart';

class AppBarGroup extends StatefulWidget {
  final Group? group;

  const AppBarGroup(
      {required this.group});

  @override
  _AppBarGroupState createState() => _AppBarGroupState();
}

class _AppBarGroupState extends State<AppBarGroup> {
  bool isAdmin = false;

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
              child: Container(
                height: 40,
                width: 40,
                color: CustomColors.primary,
            ),
          ),
        ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                widget.group != null ? widget.group!.name : "Group",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CustomColors.darkGrey,
                )
                ),
          ),
        ),
        SizedBox(width: 10,),
        NeumorphicButton(
          onPressed: () async {
            Navigator.of(context).pop();
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
