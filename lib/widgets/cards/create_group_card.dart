import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/create_group_screen.dart';

import 'card.dart';

class CreateGroupCard extends StatelessWidget {
  const CreateGroupCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: NeumorphicCard(
          groupName: 'Create Group',
          color: Colors.deepPurple,
          groupType: '',
          adminNames: [],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CreateGroupScreen(
                  user: FirebaseAuth.instance.currentUser!,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.add_circle,
            color: CustomColors.white,
            size: 50,
          )),
    );
  }
}
