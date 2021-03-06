import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:nanoid/async.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/utils/color_picker.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/widgets/app_bars/app_bar_title.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';
import 'package:uuid/uuid.dart';

final Group emptyGroup = Group(
    type: '',
    adminIDs: [FirebaseAuth.instance.currentUser!.uid],
    name: '',
    color: CustomColors.mint,
    id: Uuid().v4(),
    roomCode: '',
    noteIDs: []);
Group group = emptyGroup;

class CreateGroupScreen extends StatefulWidget {
  final User user;

  const CreateGroupScreen({Key? key, required this.user}) : super(key: key);

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  void changeColor(Color color) => setState(() => group.color = color);

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
          title: AppBarTitle(
            user: widget.user,
          ),
        ),
      ),
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          child: Icon(Icons.arrow_back, color: group.color),
          onPressed: () => {Navigator.of(context).pop()},
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
                              color: group.color,
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
                                              pickerColor: group.color,
                                              onColorChanged: changeColor,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child:
                                        Icon(Icons.edit, color: group.color)),
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
                                          labelText: 'Enter group title',
                                          maxLines: 1,
                                          icon: Icon(
                                            Icons.description,
                                            color: theme.variantColor,
                                          ),
                                          controller: _nameController),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: NeumorphicTextField(
                                          labelText: 'Enter group type',
                                          maxLines: 1,
                                          icon: Icon(
                                            Icons.article,
                                            color: theme.variantColor,
                                          ),
                                          controller: _typeController),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: NeumorphicTextField(
                                    labelText: 'Invite members via email',
                                    maxLines: 1,
                                    keyboardType: TextInputType.emailAddress,
                                    icon: Icon(Icons.email,
                                        color: theme.variantColor),
                                    controller: _emailController),
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
                                    child: ListView(
                                      children: [],
                                    )),
                              ),
                              SizedBox(height: 8),
                              Button(
                                text: 'Create group',
                                color: group.color,
                                textColor: CustomColors.nightBG,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    group.name = _nameController.value.text;
                                    group.type = _typeController.value.text;
                                    group.id = Uuid().v4();
                                    group.roomCode = await customAlphabet(
                                        '123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ',
                                        6);
                                    var db = FirebaseFirestore.instance;
                                    var userID =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    var groupDoc =
                                        db.collection('group').doc(group.id);
                                    var users = db.doc('users/$userID');

                                    final batch = db.batch();

                                    batch.set(groupDoc, {
                                      'admins': [userID],
                                      'members': [userID],
                                      'color': group.color.value,
                                      'name': group.name,
                                      'notes': [],
                                      'roomCode': group.roomCode,
                                      'type': group.type
                                    });

                                    batch.update(users, {
                                      'group':
                                          FieldValue.arrayUnion([group.id]),
                                    });

                                    batch.commit().then(
                                        (value) => print('Added to database'));

                                    group = emptyGroup;
                                  }
                                  Navigator.of(context).pop();
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = NeumorphicTheme.currentTheme(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'test@gmail.com',
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
