import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';

class NeumorphicTextField extends StatefulWidget {
  final String labelText;
  final Icon icon;
  final bool password;

  NeumorphicTextField(
      {Key? key,
      required this.labelText,
      required this.icon,
      this.password = false})
      : super(key: key);

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -3,
          intensity: 1,
        ),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: TextFormField(
          style: TextStyle(color: CustomColors.lightGrey),
          decoration: InputDecoration(
            icon: widget.icon,
            border: InputBorder.none,
            labelText: widget.labelText,
          ),
          obscureText: widget.password,
          onSaved: (String? value) {
            //TODO: Username Input
          },
        ),
      ),
    );
  }
}
