import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/widgets/app_bar_title.dart';
import 'package:notes_app/widgets/bottom_app_bar.dart';
import 'package:notes_app/widgets/card.dart';
import 'package:notes_app/widgets/note_panel.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class Group {
  String type = 'No type';
  String name = 'No group';
  Color color = Colors.red;
  List<String> admins = ['No Admins'];

  Group(String type, String name, Color color, List<String> admins) {
    this.type = type;
    this.name = name;
    this.color = color;
    this.admins = admins;
  }
}

class _UserInfoScreenState extends State<UserInfoScreen> {
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
    ]),
    Group('Class', 'English', Colors.red,
        ["Mr Grabski", "Mr Pegg", "Miss Collins", "Miss Collins"]),
    Group('Staff', 'Announcements', Colors.teal, ["Mr Grabski"]),
  ];

  List<String> notes = [
    'Lorem uadfgdfs gosdfhhhhhhhhhhhhhhhhs...',
    'Blah blah blahadfghasdf gdfs dfg sdfhgd',
    'Lorem uadfgdfs gosdfhhhhhhhhhhhhhhhhs...',
    'Blah blah blahadfghasdf gdfs dfg sdfhgd',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      bottomNavigationBar: AppBarBottom(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.white,
          title: AppBarTitle(
              photoUrl: _user.photoURL!, name: _user.displayName!, email: _user.email!,),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 316,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  itemCount: groups.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: NeumorphicCard(
                          groupName: groups[index].name,
                          color: groups[index].color,
                          onPressed: () => {},
                          groupType: groups[index].type,
                          adminNames: groups[index].admins),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              NeumorphicNoteOverview(title: 'New Notes', notes: notes, numberOfNotes: 3,),
            ],
          ),
        ),
      ),
    );
  }
}
