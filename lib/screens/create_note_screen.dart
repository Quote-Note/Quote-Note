import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/create_group_screen.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/utils/note.dart';
import 'package:notes_app/utils/profile.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';
import 'package:uuid/uuid.dart';

class CreateNoteScreen extends StatefulWidget {
  final Group group;

  const CreateNoteScreen({Key? key, required this.group}) : super(key: key);

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

final Note emptyNote = Note(
    title: '',
    body: '',
    authorID: FirebaseAuth.instance.currentUser!.displayName!,
    timestamp: DateTime.now(),
    group: emptyGroup,
    attachmentURL: tempURL,
    id: Uuid().v4());
Note note = emptyNote;

bool isUpdating = false;
String tempURL = '';

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    isUpdating = false;
    tempURL = '';

    super.initState();
  }

  Future<String> uploadToCloudinary(File file) async {
    setState(() {
      isUpdating = true;
    });

    String returnResult =
        await Profile.uploadToFirebase(context, file, 'attachments');

    setState(() {
      isUpdating = false;
    });
    return returnResult;
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
          title: AppBarGroup(group: widget.group),
        ),
      ),
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          child: Icon(Icons.arrow_back, color: theme.disabledColor),
          onPressed: () async {
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
                            color: widget.group.color,
                          ),
                        ),
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
                                          maxLines: 1,
                                          labelText: 'Enter note title',
                                          icon: Icon(
                                            Icons.description,
                                            color: theme.variantColor,
                                          ),
                                          controller: _titleController),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                  child: NeumorphicTextField(
                                      maxLines: 6,
                                      keyboardType: TextInputType.multiline,
                                      labelText: 'Enter note',
                                      icon: Icon(
                                        Icons.notes,
                                        color: theme.variantColor,
                                      ),
                                      controller: _noteController)),
                              SizedBox(height: 8),
                              Expanded(
                                child: Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: 3,
                                    intensity: 1,
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                          color: widget.group.color,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: tempURL != ''
                                              ? Image.network(
                                                  tempURL,
                                                  key: UniqueKey(),
                                                  scale: 1,
                                                  fit: BoxFit.cover,
                                                )
                                              : Container()),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: !isUpdating
                                              ? NeumorphicButton(
                                                  style: NeumorphicStyle(
                                                    color: theme.baseColor,
                                                    boxShape: NeumorphicBoxShape
                                                        .circle(),
                                                    depth: 5,
                                                    intensity: 0,
                                                  ),
                                                  onPressed: () async {
                                                    File? attatchment =
                                                        await Profile
                                                            .pickFile();
                                                    if (attatchment != null) {
                                                      String _photoURL =
                                                          await uploadToCloudinary(
                                                              attatchment);
                                                      setState(() {
                                                        tempURL = _photoURL;
                                                      });
                                                    }
                                                  },
                                                  child: Icon(Icons.file_upload,
                                                      color:
                                                          widget.group.color))
                                              : CircularProgressIndicator(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Button(
                                text: 'Create note',
                                color: widget.group.color,
                                textColor: CustomColors.nightBG,
                                onPressed: () async {
                                  if (!isUpdating) {
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        note.note = _noteController.value.text;
                                        note.title =
                                            _titleController.value.text;
                                        note.attachmentURL = tempURL;
                                        note.id = Uuid().v4();

                                        var db = FirebaseFirestore.instance;
                                        var userID = FirebaseAuth
                                            .instance.currentUser!.uid;
                                        var groupDoc = db
                                            .collection('group')
                                            .doc(widget.group.id);
                                        var users = db.doc('users/$userID');
                                        var notes =
                                            db.collection('notes').doc(note.id);

                                        final batch = db.batch();

                                        batch.update(groupDoc, {
                                          'notes':
                                              FieldValue.arrayUnion([note.id])
                                        });

                                        batch.update(users, {
                                          'notes':
                                              FieldValue.arrayUnion([note.id]),
                                        });

                                        batch.set(notes, {
                                          'authorID': userID,
                                          'note': _noteController.value.text,
                                          'timestamp':
                                              FieldValue.serverTimestamp(),
                                          'title': note.title,
                                          'groupID': widget.group.id,
                                          'attachmentURL': note.attachmentURL
                                        });

                                        batch.commit().then((value) =>
                                            print('Added to database'));

                                        tempURL = '';

                                        note = emptyNote;

                                        Navigator.of(context).pop();
                                      }
                                    });
                                  }
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
