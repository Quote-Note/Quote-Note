import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/utils/color_picker.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/utils/routes.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';

import 'notes_screen.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({
    Key? key,
    required Group group,
  })   : _group = group,
        super(key: key);

  final Group _group;
  

  @override
  _EditGroupScreenState createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  Color initalColor = Colors.red;
  

  Future<String> getMemberEmail(String id) async {
    QuerySnapshot users = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: id)
        .get();
    DocumentSnapshot document = users.docs.first;
    return document.get('display_name');
  }

  void changeColor(Color color) => setState(() => widget._group.color = color);

  @override
  void initState() { 
    initalColor = widget._group.color;
    _nameController.value = TextEditingValue(text: widget._group.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Scaffold(
      backgroundColor: theme.baseColor,
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          brightness: NeumorphicTheme.of(context)!.themeMode == ThemeMode.light
              ? Brightness.light
              : Brightness.dark,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: AppBarGroup(group: widget._group),
        ),
      ),
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          child: Icon(Icons.arrow_back, color: theme.disabledColor),
          onPressed: ()  {
            widget._group.color = initalColor;
            Navigator.of(context).pop();
            },
          style: NeumorphicStyle(boxShape: NeumorphicBoxShape.circle()),
        )
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Flex(
            direction: Axis.vertical,
            children: [
              Expanded(
                child: Neumorphic(
                  style: NeumorphicStyle(
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
                    depth: 4,
                    intensity: 1,
                  ),
                  child: Flex(
                    direction: Axis.vertical,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              color: widget._group.color,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: NeumorphicButton(
                                    style: NeumorphicStyle(
                                      color: theme.baseColor,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      depth: 5,
                                      intensity: 0,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor: Colors.transparent,
                                            titlePadding:
                                                const EdgeInsets.all(0.0),
                                            contentPadding:
                                                const EdgeInsets.all(8.0),
                                            content: BlockPicker(
                                              availableColors: CustomColors.colors,
                                              pickerColor: widget._group.color,
                                              onColorChanged: changeColor,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.edit,
                                        color: widget._group.color)),
                              ),
                            )),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Form(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: NeumorphicTextField(
                                          labelText: 'Edit group title',
                                          icon: Icon(
                                            Icons.description,
                                            color: theme.variantColor,
                                          ),
                                          controller: _nameController),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child: Neumorphic(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    style: NeumorphicStyle(
                                      depth: -2,
                                      intensity: 1,
                                    ),
                                    child: Member(email: "test", admin: false,)),
                              ),
                              SizedBox(height: 8),
                              Button(
                                text: 'Save group',
                                color: widget._group.color,
                                textColor: CustomColors.nightBG,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    widget._group.name = _nameController.value.text;
                                    var db = FirebaseFirestore.instance;
                                    var groupDoc =
                                        db.collection('group').doc(widget._group.id);

                                    final batch = db.batch();

                                    batch.update(groupDoc, {
                                      'color': widget._group.color.value,
                                      'name': widget._group.name,
                                    });

                                    batch.commit().then(
                                        (value) => print('Updated database'));

                                  }
                                  setState(() {
                                    Navigator.of(context).pop();
                                    //Routes.routeTo(NotesScreen(group: widget._group));
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Member extends StatelessWidget {
  const Member({
    Key? key,
    required this.email,
    required this.admin,
  }) : super(key: key);

  final String email;
  final bool admin;

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            email,
            style: TextStyle(color: theme.variantColor),
          ),
          NeumorphicButton(
            padding: EdgeInsets.all(10),
            onPressed: () async {},
            style: NeumorphicStyle(
              depth: 3,
              intensity: 1,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            child: ClipOval(
              child: Icon(
                Icons.star,
                color: theme.variantColor,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
