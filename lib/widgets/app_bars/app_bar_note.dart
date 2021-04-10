
import 'package:flutter/material.dart';
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
              child: Container(
                height: 40,
                width: 40,
                color: theme.disabledColor
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
                  color: theme.defaultTextColor,
                )
                ),
          ),
        ),
        SizedBox(width: 10,),
      ],
    );
  }
}
