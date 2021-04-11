import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicCard extends StatefulWidget {
  final String groupName;
  final String groupType;
  final List<User> adminNames;
  final Color color;
  final Function()? onPressed;
  final Icon? icon;

  const NeumorphicCard({
    Key? key,
    required this.groupName,
    required this.color,
    this.onPressed,
    required this.groupType,
    required this.adminNames,
    this.icon,
  }) : super(key: key);

  @override
  _NeumorphicCardState createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard> {
  @override
  Widget build(BuildContext context) {
    return widget.onPressed != null
        ? NeumorphicButton(
            onPressed: widget.onPressed,
            padding: const EdgeInsets.all(0),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
              depth: 4,
              intensity: 1,
            ),
            child: CardContent(
                groupName: widget.groupName,
                groupType: widget.groupType,
                color: widget.color,
                adminNames: widget.adminNames,
                icon: widget.icon),
          )
        : Neumorphic(
            padding: const EdgeInsets.all(0),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
              depth: 4,
              intensity: 1,
            ),
            child: CardContent(
                groupName: widget.groupName,
                groupType: widget.groupType,
                color: widget.color,
                adminNames: widget.adminNames,
                icon: widget.icon));
  }
}

class CardContent extends StatelessWidget {
  final String groupName;
  final String groupType;
  final List<User> adminNames;
  final Color color;
  final Icon? icon;

  const CardContent({
    Key? key,
    required this.groupName,
    required this.color,
    required this.groupType,
    required this.adminNames,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);

    String convertToNames() {
      List<String> names = [];
      adminNames.forEach((element) {
        names.add((element.displayName != null
            ? element.displayName
            : element.email
                .toString()
                .substring(0, element.email.toString().indexOf('@')))!);
      });
      return names.join(' & ');
    }

    return Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Container(
          height: 168,
          width: 282,
          decoration: BoxDecoration(
            color: color,
          ),
          child: icon != null ? icon : Container(),
        ),
        Expanded(
          child: Container(
            width: 282,
            decoration: BoxDecoration(
              color: theme.baseColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 10),
                  Text(groupType, style: TextStyle(color: color)),
                  Text(
                    groupName,
                    style: TextStyle(
                      color: theme.defaultTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    convertToNames(),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.variantColor,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
