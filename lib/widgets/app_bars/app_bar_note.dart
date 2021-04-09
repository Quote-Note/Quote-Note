
import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/notes_screen.dart';

class AppBarNote extends StatefulWidget {
  final Note? note;

  const AppBarNote(
      {required this.note});

  @override
  _AppBarNoteState createState() => _AppBarNoteState();
}

class _AppBarNoteState extends State<AppBarNote> {
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
                "Note",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CustomColors.darkGrey,
                )
                ),
          ),
        ),
        SizedBox(width: 10,),
      ],
    );
  }
}