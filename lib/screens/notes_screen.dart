import 'package:cloud_firestore/cloud_firestore.dart';
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
  //Function(String) removeGroup;

  NotesScreen({Key? key, required this.group}) : super(key: key);

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

  void removeNote(String noteID) {
    setState(() {});
  }

  Future<String> getUserName(String userID) async {
    QuerySnapshot user;
    user = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: userID)
        .get();
    DocumentSnapshot documents = user.docs[0];
    return documents.get('display_name');
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
        /* NeumorphicButton(
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
                        //widget.removeGroup(widget.group.id);
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
        ), */
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
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('notes')
                      .where('groupID', isEqualTo: _group.id)
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    int length = 0;
                    if (snapshot.hasData) {
                      length = snapshot.data!.docs.length;
                    }
                    
                    return ListView.builder(
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.vertical,
                      itemCount: length,
                      itemBuilder: (BuildContext context, int index) {
                        var doc = snapshot.data!.docs[index];

                        Timestamp timestamp =
                            doc.get('timestamp') ?? Timestamp.now();
                        

                        var note = Note(
                          title: doc.get('title'),
                          body: doc.get('note'),
                          authorID: doc.get('authorID'),
                          id: doc.id,
                          group: _group,
                          attachmentURL: '',
                          timestamp: timestamp.toDate(),
                        );
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          child: NeumorphicNote(
                            note: note,
                            removeNote: removeNote,
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
