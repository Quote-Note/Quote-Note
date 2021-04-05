import 'package:flutter/material.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/screens/sign_up_screen.dart';
import 'package:notes_app/utils/auth.dart';

class AppBarBottom extends StatefulWidget {
  const AppBarBottom();

  @override
  _AppBarBottomState createState() => _AppBarBottomState();
}

class _AppBarBottomState extends State<AppBarBottom> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: Neumorphic(
              style: NeumorphicStyle(
                depth: -2,
                intensity: 1,
                boxShape: NeumorphicBoxShape.rect(),
                color: CustomColors.white,
              ),
              padding: const EdgeInsets.all(5),
            ),
          ),
        ),
      ],
    );
  }
}
