import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/user_info_screen.dart';
import 'package:notes_app/widgets/app_bars/app_bar_title.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/text_field.dart';

import '../button.dart';

class CreateGroupExpanded extends StatefulWidget {
  const CreateGroupExpanded({
    Key? key,
    required User user,
  })   : _user = user,
        super(key: key);

  final User _user;

  @override
  _CreateGroupExpandedState createState() => _CreateGroupExpandedState();
}

class _CreateGroupExpandedState extends State<CreateGroupExpanded> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: CustomColors.white,
          title: AppBarTitle(
            user: widget._user,
          ),
        ),
      ),
      bottomNavigationBar: AppBarBottom(buttons: [
        NeumorphicButton(
          child: Icon(Icons.arrow_back, color: CustomColors.primary),
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
                              color: CustomColors.primary,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: NeumorphicButton(
                                    style: NeumorphicStyle(
                                      color: CustomColors.white,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      depth: 5,
                                      intensity: 0,
                                    ),
                                    onPressed: () {},
                                    child: Icon(Icons.edit,
                                        color: CustomColors.primary)),
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
                                          icon: Icon(Icons.description),
                                          controller: _nameController),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: NeumorphicTextField(
                                          labelText: 'Invite members via email',
                                          icon: Icon(Icons.email),
                                          controller: _emailController),
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
                                    child: ListView(
                                      children: [
                                        Member(),
                                        Member(),
                                        Member(),
                                        Member(),
                                        Member(),
                                        Member(),
                                        Member(),
                                        Member(),
                                        Member(),
                                      ],
                                    )),
                              ),
                              SizedBox(height: 8),
                              Button(
                                text: 'Create group',
                                color: CustomColors.primary,
                                textColor: CustomColors.white,
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

class Member extends StatelessWidget {
  const Member({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'test@gmail.com',
            style: TextStyle(color: CustomColors.lightGrey),
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
                color: CustomColors.lightGrey,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
