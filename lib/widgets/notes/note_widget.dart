import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/utils/note.dart';

import 'closed_note.dart';
import 'expanded_note.dart';

class NeumorphicNote extends StatefulWidget {
  final Note note;
  final Function(String) removeNote;

  const NeumorphicNote({
    Key? key,
    required this.note,
    required this.removeNote,
  }) : super(key: key);

  @override
  _NeumorphicNoteState createState() => _NeumorphicNoteState();
}

class _NeumorphicNoteState extends State<NeumorphicNote> {
  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Flex(
      direction: Axis.horizontal,
      children: [
        Flexible(
          child: OpenContainer(
              clipBehavior: Clip.none,
              closedElevation: 0,
              transitionType: ContainerTransitionType.fadeThrough,
              closedColor: theme.baseColor,
              openColor: theme.baseColor,
              middleColor: theme.baseColor,
              openBuilder: (context, action) {
                return ExpandedNote(note: widget.note, removeNote: widget.removeNote);
              },
              closedBuilder: (context, action) {
                return ClosedNote(note: widget.note);
              }),
        ),
      ],
    );
  }
}