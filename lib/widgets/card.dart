import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';

class NeumorphicCard extends StatefulWidget {
  final String groupName;
  final String groupType;
  final List<String> adminNames;
  final Color color;
  final Function() onPressed;

  const NeumorphicCard(
      {Key? key,
      required this.groupName,
      required this.color,
      required this.onPressed,
      required this.groupType,
      required this.adminNames})
      : super(key: key);

  @override
  _NeumorphicCardState createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard> {
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
        depth: 4,
        intensity: 1,
        color: CustomColors.primary,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            height: 316.0,
            width: 282.0,
            decoration: BoxDecoration(
              color: widget.color,
            ),
          ),
          Container(
            height: 168,
            width: 282.0,
            decoration: BoxDecoration(
              color: CustomColors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 10),
                Text(widget.groupType,
                    style: TextStyle(
                      color: widget.color
                    )),
                Text(
                  widget.groupName,
                  style: TextStyle(
                    color: CustomColors.darkGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.adminNames.join(' & '),
                  style: TextStyle(
                    color: CustomColors.lightGrey,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
