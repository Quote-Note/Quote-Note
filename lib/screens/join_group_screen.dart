import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/widgets/app_bars/app_bar_title.dart';
import 'package:notes_app/widgets/app_bars/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({
    Key? key,
    required User user,
  })   : _user = user,
        super(key: key);

  final User _user;

  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();

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
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 0,
                                child: Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: NeumorphicTextField(
                                            labelText: 'Enter a group code',
                                            icon: Icon(Icons.description),
                                            controller: _codeController),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                flex: 0,
                                child: Neumorphic(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    style: NeumorphicStyle(
                                      depth: -2,
                                      intensity: 1,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Maths - G3452',
                                            style: TextStyle(
                                                color: CustomColors.lightGrey),
                                          ),
                                          NeumorphicButton(
                                            padding: EdgeInsets.all(10),
                                            onPressed: () async {},
                                            style: NeumorphicStyle(
                                              depth: 3,
                                              intensity: 1,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                            ),
                                            child: ClipOval(
                                              child: Icon(
                                                Icons.login,
                                                color: CustomColors.lightGrey,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                              Expanded(child: Container()),
                              Expanded(
                                flex: 0,
                                child: Button(
                                  text: 'Join group',
                                  color: CustomColors.primary,
                                  textColor: CustomColors.white,
                                  onPressed: () async {},
                                ),
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
