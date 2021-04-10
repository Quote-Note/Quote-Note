import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/notes/note.dart';

import 'user_info_screen.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key, required Group group})
      : _group = group,
        super(key: key);

  final Group _group;

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class Note {
  String title = 'Note';
  String note = '';
  String author = 'No one';
  DateTime timestamp = DateTime.utc(2021, 03, 31);

  Note(String title, String body, String author, DateTime timestamp) {
    this.title = title;
    this.note = body;
    this.author = author;
    this.timestamp = timestamp;
  }
}

class _NotesScreenState extends State<NotesScreen> {
  late Group _group;

  @override
  void initState() {
    _group = widget._group;

    super.initState();
  }

  List<Note> _notes = [
    Note(
        'Equation',
        'Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
        'Joe',
        DateTime.utc(2021, 03, 31)),
    Note('Class', 'Maths', 'Test', DateTime.utc(2021, 03, 31)),
    Note('Equation', 'Lorem ipsum', 'Joe', DateTime.utc(2021, 04, 7)),
    Note('Class', 'Maths', 'Test', DateTime.utc(2020, 03, 31)),
  ];

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
    onPressed: () {},
    child: Icon(Icons.add, color: theme.defaultTextColor,),
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
                  itemCount: _notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: NeumorphicNote(
                        note: _notes[index],
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
