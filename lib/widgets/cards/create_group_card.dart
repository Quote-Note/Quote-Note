import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/create_group_screen.dart';
import 'package:notes_app/utils/group.dart';

import 'card.dart';

class CreateGroupCard extends StatelessWidget {
  CreateGroupCard({
    Key? key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: NeumorphicCard(
          groupName: 'Create Group',
          color: CustomColors.lavender,
          groupType: '',
          adminNames: [],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateGroupScreen(
                  user: FirebaseAuth.instance.currentUser!,
                  key: key,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.add_circle,
            color: Colors.white,
            size: 50,
          )),
    );
  }
}
