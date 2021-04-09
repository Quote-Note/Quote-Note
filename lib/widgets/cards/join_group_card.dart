import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/join_group_screen.dart';

import 'card.dart';

class JoinGroupCard extends StatelessWidget {
  const JoinGroupCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: NeumorphicCard(
          groupName: 'Join Group',
          color: Colors.deepOrange,
          groupType: '',
          adminNames: [],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => JoinGroupScreen(
                  user: FirebaseAuth.instance.currentUser!,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.group_add,
            color: CustomColors.white,
            size: 50,
          )),
    );
  }
}
