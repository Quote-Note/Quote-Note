import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/utils/group.dart';

class AppBarGroup extends StatefulWidget {
  final Group? group;

  const AppBarGroup(
      {required this.group});

  @override
  _AppBarGroupState createState() => _AppBarGroupState();
}

class _AppBarGroupState extends State<AppBarGroup> {
  bool isAdmin = false;

  void toggleAdmin() {
    setState(() {
      isAdmin = !isAdmin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Row(
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            depth: -1,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: SizedBox(
            height: 40,
            width: 40,
            child: ClipOval(
              child: Container(
                height: 40,
                width: 40,
                color: widget.group!.color,
                child: Icon(Icons.group, color: CustomColors.nightBG,),
            ),
          ),
        ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
                widget.group != null ? widget.group!.name : "Group",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: theme.defaultTextColor,
                )
                ),
          ),
        ),
        SizedBox(width: 10,),
        
      ],
    );
  }
}
