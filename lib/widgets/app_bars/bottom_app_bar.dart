import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AppBarBottom extends StatefulWidget {
  final List<Widget> buttons;

  const AppBarBottom({required this.buttons});

  @override
  _AppBarBottomState createState() => _AppBarBottomState();
}

class _AppBarBottomState extends State<AppBarBottom> {
  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
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
                color: theme.baseColor,
              ),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.buttons.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 3),
                        child: Column(
                          children: [
                            Expanded(
                              child: widget.buttons.length > 0
                                  ? widget.buttons[index]
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
