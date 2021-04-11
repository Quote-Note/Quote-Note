import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/notes/note.dart';

import 'create_note_screen.dart';
import 'edit_group_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key, required Group group})
      : _group = group,
        super(key: key);

  final Group _group;

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Group _group;

  @override
  void initState() {
    _group = widget._group;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      backgroundColor: theme.baseColor,
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: 3,
            intensity: 1,
          ),
          onPressed: () {Navigator.of(context).push(
                                      Routes.routeTo(
                                        CreateNoteScreen(group: _group)));},
          child: Icon(
            Icons.add,
            color: theme.defaultTextColor,
          ),
        ),
        NeumorphicButton(
          onPressed: () async {
            Navigator.of(context).push(Routes.routeTo(EditGroupScreen(group: _group)));
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.menu_rounded,
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
        ),
      ]),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          brightness: NeumorphicTheme.of(context)!.themeMode == ThemeMode.light
              ? Brightness.light
              : Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: AppBarGroup(
            group: _group,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: ListView.builder(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.vertical,
                  itemCount: _group.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: NeumorphicNote(
                        note: _group.notes[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
