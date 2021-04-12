import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/utils/note.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/notes/note_widget.dart';

import 'create_note_screen.dart';
import 'edit_group_screen.dart';

class NotesScreen extends StatefulWidget {

  Group group;
  Function(Group group) removeGroup;

  NotesScreen({Key? key, required this.group, required this.removeGroup}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late Group _group;

  @override
  void initState() {
    _group = widget.group;

    super.initState();
  }

  void addNote(Note note) {
    setState(() {
      _group.notes.add(note);
      //_group = widget._group;
    });
  }

  void removeNote(Note note) {
    setState(() {
      _group.notes.remove(note);
      //_group = widget._group;
    });
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
          onPressed: () {
            Navigator.of(context).push(Routes.routeTo(CreateNoteScreen(
              group: _group,
              refresh: addNote,
            )));
          },
          child: Icon(
            Icons.add,
            color: theme.defaultTextColor,
          ),
        ),
        NeumorphicButton(
          onPressed: () async {
            Navigator.of(context)
                .push(Routes.routeTo(EditGroupScreen(group: _group)));
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
            return showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Leave group?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Leave', style: TextStyle(color: CustomColors.red),),
                      onPressed: () {
                        widget.removeGroup(widget.group);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Stay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.logout,
              color: CustomColors.red,
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
                  clipBehavior: Clip.antiAlias,
                  scrollDirection: Axis.vertical,
                  itemCount: _group.notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    //Sorts by most recent
                    _group.notes
                        .sort((a, b) => b.timestamp.compareTo(a.timestamp));
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: NeumorphicNote(
                        note: _group.notes[index],
                        removeNote: removeNote,
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
