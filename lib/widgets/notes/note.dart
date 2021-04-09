import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/notes_screen.dart';

import 'closed_note.dart';
import 'expanded_note.dart';

class NeumorphicNote extends StatefulWidget {
  final Note note;

  const NeumorphicNote({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  _NeumorphicNoteState createState() => _NeumorphicNoteState();
}

class _NeumorphicNoteState extends State<NeumorphicNote> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: OpenContainer(
              clipBehavior: Clip.none,
              closedElevation: 0,
              transitionType: ContainerTransitionType.fadeThrough,
              closedColor: CustomColors.white,
              openColor: CustomColors.white,
              openBuilder: (context, action) {
                return ExpandedNote(note: widget.note);
              },
              closedBuilder: (context, action) {
                return ClosedNote(note: widget.note);
              }),
        ),
      ],
    );
  }
}