import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/utils/note.dart';
import 'package:timeago/timeago.dart' as timeago;

class ClosedNote extends StatelessWidget {
  ClosedNote({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;
  String username = '';

  getUsername() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: note.authorID)
        .get()
        .then((value) {
      username = value.docs.first.data()!['display_name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(30)),
        depth: 4,
        intensity: 1,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 10),
            Text(
              note.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.defaultTextColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: FutureBuilder(
                    future: getUsername(),
                    builder: (context, snapshot) {
                      return Text(
                        username,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: theme.defaultTextColor,
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    '• ${timeago.format(note.timestamp, locale: 'en_short')}',
                    style: TextStyle(
                      color: theme.variantColor,
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
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                note.note,
                maxLines: 6,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.variantColor,
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
