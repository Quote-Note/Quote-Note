import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/notes_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class ClosedNote extends StatelessWidget {
  const ClosedNote({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        depth: 4,
        intensity: 1,
      ),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                note.title,
                style: TextStyle(
                  color: CustomColors.darkGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  note.author,
                  style: TextStyle(
                    color: CustomColors.darkGrey,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Text(
                  '• ${timeago.format(note.timestamp, locale: 'en_short')}',
                  style: TextStyle(
                    color: CustomColors.lightGrey,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                note.note,
                maxLines: 6,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: CustomColors.lightGrey,
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
