
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/utils/note.dart';
import 'package:notes_app/widgets/app_bars/app_bar_note.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:timeago/timeago.dart' as timeago;


class ExpandedNote extends StatelessWidget {
  final Note note;
  final Function(String) removeNote;
  const ExpandedNote({required this.note, required this.removeNote});

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      backgroundColor: theme.baseColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          brightness: NeumorphicTheme.of(context)!.themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: theme.baseColor,
          title: AppBarNote(note: note),
        ),
      ),
      bottomNavigationBar: AppBarBottom(
        buttons: [NeumorphicButton(
          onPressed: () async {
            removeNote(note.id);
            Navigator.of(context).pop();
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.delete,
              color: theme.defaultTextColor,
            ),
          ),
        ),
        NeumorphicButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.arrow_back,
              color: theme.disabledColor,
            ),
          ),
        ),],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
                    depth: 4,
                    intensity: 1,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            color: theme.baseColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  note.title,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: theme.defaultTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      note.author,
                                      style: TextStyle(
                                        color: theme.variantColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Text(
                                        '• ${timeago.format(note.timestamp, locale: 'en_short')}',
                                        style: TextStyle(
                                          color: theme.variantColor,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  note.note,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 10,
                                  style: TextStyle(
                                      color: theme.defaultTextColor,
                                      height: 1.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: theme.disabledColor,
                          ),
                          child: note.attachmentURL.isNotEmpty ? Image.network(
                                            note.attachmentURL,
                                            key:
                                                UniqueKey(),
                                            scale: 1,
                                            fit: BoxFit.cover,
                                          ): Container(),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
