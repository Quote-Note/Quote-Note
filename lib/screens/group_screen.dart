import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
  GroupScreenState createState() => GroupScreenState();
}

List<Group> groups = [];

class GroupScreenState extends State<GroupScreen> {
  late User _user;
  
  List<String> notes = [
    'Lorem uadfgdfs gosdfhhhhhhhhhhhhhhhhs...',
    'Blah blah blahadfghasdf gdfs dfg sdfhgd',
    'Lorem uadfgdfs gosdfhhhhhhhhhhhhhhhhs...',
    'Blah blah blahadfghasdf gdfs dfg sdfhgd',
  ];

  void addGroup(Group group){
    setState(() {
      groups.insert(0,group);
    });
  }

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.baseColor,
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          onPressed: () => {
            Navigator.of(context).pushReplacement(
                Routes.routeTo(ProfileScreen(user: widget._user)))
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
            Navigator.of(context)
                .pushReplacement(Routes.routeTo(SignInScreen()));
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
          brightness: NeumorphicTheme.of(context)!.themeMode == ThemeMode.light
              ? Brightness.light
              : Brightness.dark,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ListView.builder(
                    addRepaintBoundaries: false,
                    itemExtent: 300,
                    scrollDirection: Axis.horizontal,
                    clipBehavior: Clip.none,
                    itemCount: groups.length + 2,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < groups.length) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: NeumorphicCard(
                              groupName: groups[index].name,
                              color: groups[index].color,
                              onPressed: () => {
                                    Navigator.of(context).push(Routes.routeTo(
                                        NotesScreen(group: groups[index])))
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
