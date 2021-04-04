import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarTitle extends StatelessWidget {
  final String photoUrl;
  final String name;

  const AppBarTitle({required this.photoUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(width: 8),
        Neumorphic(
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Material(
              color: CustomColors.lightShadow.withOpacity(0.3),
              child: Image.network(
                photoUrl,
                scale: 2.5,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
