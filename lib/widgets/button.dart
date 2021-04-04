import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';

class Button extends StatefulWidget {

  final String text;
  final Color color;
  final Color textColor;
  final Function() onPressed;

  const Button({
    Key? key, required this.text, required this.color, required this.onPressed, required this.textColor
  }) : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: NeumorphicButton(
        onPressed: widget.onPressed,
        padding: const EdgeInsets.all(20),
        child: Text(
          widget.text,
          style: TextStyle(color: widget.textColor, fontSize: 16),
          textAlign: TextAlign.center,
        ),
        style: NeumorphicStyle(
          color: widget.color,
          depth: 3,
          shape: NeumorphicShape.concave,
          intensity: 1,
        ),
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
