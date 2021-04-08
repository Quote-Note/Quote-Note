import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';

import 'card.dart';

class CreateGroupClosed extends StatelessWidget {
  const CreateGroupClosed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 10),
      child: NeumorphicCard(
          groupName: 'Create Group',
          color: Colors.deepPurple,
          groupType: '',
          adminNames: [],
          icon: Icon(
            Icons.add_circle,
            color: CustomColors.white,
            size: 50,
          )),
    );
  }
}
