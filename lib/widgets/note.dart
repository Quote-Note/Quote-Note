import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';

class NeumorphicNote extends StatefulWidget {
  final String title;
  final String note;
  final String author;

  const NeumorphicNote({
    Key? key,
    required this.title,
    required this.note,
    required this.author,
  }) : super(key: key);

  @override
  _NeumorphicNoteState createState() => _NeumorphicNoteState();
}

class _NeumorphicNoteState extends State<NeumorphicNote> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 174,
      width: 343,
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
          depth: 4,
          intensity: 1,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: CustomColors.darkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:5),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: CustomColors.darkGrey,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:0),
                  child: Text(
                    '• 5h',
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
            SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    widget.note,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: CustomColors.lightGrey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
