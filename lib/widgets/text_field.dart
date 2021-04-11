import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class NeumorphicTextField extends StatefulWidget {
  final String labelText;
  final Icon icon;
  final bool password;
  int? maxLines = 1;
  TextInputType? keyboardType = TextInputType.text;
  final TextEditingController controller;

  NeumorphicTextField(
      {Key? key,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.keyboardType,
      this.maxLines,
      this.password = false})
      : super(key: key);

  @override
  _NeumorphicTextFieldState createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return SizedBox(
      width: double.infinity,
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -3,
          intensity: 1,
        ),
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: TextFormField(
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          style: TextStyle(color: theme.variantColor),
          decoration: InputDecoration(
            icon: widget.icon,
            border: InputBorder.none,
            labelText: widget.labelText,
            labelStyle: TextStyle(color: theme.variantColor),
          ),
          validator: (String? value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          obscureText: widget.password,
        ),
      ),
    );
  }
}
