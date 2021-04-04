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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Neumorphic(
          style: NeumorphicStyle(
            depth: -1,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Material(
              color: CustomColors.lightShadow.withOpacity(0.3),
              child: Image.network(
                photoUrl,
                scale: 2,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Text(
          name,
          style: TextStyle(
            color: CustomColors.darkGrey,
          )
        ),
        NeumorphicButton(
          //TODO
          onPressed: () => {},
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Material(
              color: CustomColors.lightShadow.withOpacity(0.3),
              child: Icon(Icons.star_border_outlined, color: CustomColors.darkGrey),
            ),
          ),
        ),
        NeumorphicButton(
          //TODO
          onPressed: () => {},
          style: NeumorphicStyle(
            depth: 3,
            intensity: 1,
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: Material(
              color: CustomColors.lightShadow.withOpacity(0.3),
              child: Icon(Icons.home, color: CustomColors.primary,),
            ),
          ),
        ),
      ],
    );
  }
}
