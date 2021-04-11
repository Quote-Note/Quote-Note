import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/utils/group.dart';
import 'package:notes_app/widgets/app_bars/app_bar_group.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({
    Key? key,
    required Group group,
  })   : _group = group,
        super(key: key);

  final Group _group;

  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

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
                            color: widget._group.color,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/dummy_image.jpg"),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: NeumorphicButton(
                                              style: NeumorphicStyle(
                                                color: theme.baseColor,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                depth: 5,
                                                intensity: 0,
                                              ),
                                              onPressed: () {},
                                              child: Icon(Icons.file_upload,
                                                  color: widget._group.color)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Button(
                                text: 'Create note',
                                color: widget._group.color,
                                textColor: CustomColors.nightBG,
                                onPressed: () async {},
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
