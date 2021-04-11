import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/profile_screen.dart';
import 'package:notes_app/screens/sign_in_screen.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/utils/note.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/widgets/app_bars/app_bar_title.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/cards/card.dart';
import 'package:notes_app/widgets/cards/create_group_card.dart';
import 'package:notes_app/widgets/cards/join_group_card.dart';

import 'package:notes_app/widgets/notes/note_overview.dart';

import 'notes_screen.dart';

class GroupScreen extends StatefulWidget {
  const GroupScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _GroupScreenState createState() => _GroupScreenState();
}





List<Note> dummyNotes = [
    Note(
        'Equation',
        'Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsumipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum',
        'Joe',
        DateTime.utc(2021, 03, 31)),
    Note('Class', 'Maths', 'Test', DateTime.utc(2021, 03, 31)),
    Note('Equation', 'Lorem ipsum', 'Joe', DateTime.utc(2021, 04, 7)),
    Note('Class', 'Maths', 'Test', DateTime.utc(2020, 03, 31)),
  ];

class _GroupScreenState extends State<GroupScreen> {
  late User _user;

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  //Dummy data
  List<Group> groups = [
    Group('Class', 'Maths', CustomColors.yellow, [
      "Mr Grabski",
      "Mr Pegg",
      "Miss Collins",
      "Miss Collins",
      "Miss Collins"
    ], dummyNotes),
    Group('Class', 'English', CustomColors.red,
        ["Mr Grabski", "Mr Pegg", "Miss Collins", "Miss Collins"], dummyNotes),
    Group('Staff', 'Announcements', CustomColors.mint, ["Mr Grabski"], dummyNotes),
  ];

  List<String> notes = [
    'Lorem uadfgdfs gosdfhhhhhhhhhhhhhhhhs...',
    'Blah blah blahadfghasdf gdfs dfg sdfhgd',
    'Lorem uadfgdfs gosdfhhhhhhhhhhhhhhhhs...',
    'Blah blah blahadfghasdf gdfs dfg sdfhgd',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.baseColor,
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          onPressed: () => {
            Navigator.of(context)
                .pushReplacement(Routes.routeTo(ProfileScreen(user: widget._user)))
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.person_rounded,
              color: theme.defaultTextColor,
            ),
          ),
        ),
        NeumorphicButton(
          onPressed: () async {
            setState(() {});
            await Authentication.signOut(context: context);
            setState(() {});
            Navigator.of(context).pushReplacement(Routes.routeTo(SignInScreen()));
          },
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          child: ClipOval(
            child: Icon(
              Icons.logout,
              color: theme.disabledColor,
            ),
          ),
        ),
      ]),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          brightness: NeumorphicTheme.of(context)!.themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: AppBarTitle(
            user: _user,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: groups.length + 2,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < groups.length) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: NeumorphicCard(
                            groupName: groups[index].name,
                            color: groups[index].color,
                            onPressed: () => {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => NotesScreen(
                                        group: groups[index],
                                      ),
                                    ),
                                  )
                                },
                            groupType: groups[index].type,
                            adminNames: groups[index].admins),
                      );
                    } else if (index == groups.length + 1) {
                      return CreateGroupCard();
                    } else {
                      return JoinGroupCard();
                    }
                  },
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
                  child: NeumorphicNoteOverview(
                    title: 'New Notes',
                    notes: notes,
                    numberOfNotes: 3,
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
