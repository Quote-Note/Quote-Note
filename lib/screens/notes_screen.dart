import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/note.dart';

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

  Note(String title, String note, String author) {
    this.title = title;
    this.note = note;
    this.author = author;
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
    Note('Equation', 'Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum', 'Joe'),
    Note('Class', 'Maths', 'Test'),
    Note('Equation', 'Lorem ipsum', 'Joe'),
    Note('Class', 'Maths', 'Test'),
  ];

  static Widget button = NeumorphicButton(
    style: NeumorphicStyle(
      boxShape: NeumorphicBoxShape.circle(),
      depth: 3,
      intensity: 1,
    ),
    onPressed: () {},
    child: Icon(Icons.add),
  );

  final List<Widget> bottomAppBarButtons = [button];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      bottomNavigationBar: AppBarBottom(buttons: bottomAppBarButtons),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: CustomColors.white,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0,20,0,0),
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.vertical,
                    itemCount: _notes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: NeumorphicNote(
                          title: _notes[index].title,
                          note: _notes[index].note,
                          author: _notes[index].author,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
