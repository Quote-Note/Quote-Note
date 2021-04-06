import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:notes_app/res/custom_colors.dart';
import 'package:notes_app/screens/user_info_screen.dart';
import 'package:notes_app/utils/auth.dart';
import 'package:notes_app/widgets/app_bar_profile.dart';
import 'package:notes_app/widgets/bottom_app_bar.dart';
import 'package:notes_app/widgets/button.dart';
import 'package:notes_app/widgets/text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required User user})
      : _user = user,
        super(key: key);

  final User _user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class Group {
  String type = 'No type';
  String name = 'No group';
  Color color = Colors.red;
  List<String> admins = ['No Admins'];

  Group(String type, String name, Color color, List<String> admins) {
    this.type = type;
    this.name = name;
    this.color = color;
    this.admins = admins;
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User _user;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  Future<File> pickFile() async {
    FilePickerResult result =
        (await FilePicker.platform.pickFiles(type: FileType.image))!;

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      // User canceled the picker
      throw ("User cancelled file picker");
    }
  }

  Future<String> uploadToCloudinary(File file) async {
    var time = DateTime.now().toUtc().microsecondsSinceEpoch;
    var signatureString =
        'timestamp=${time}OKSk1CR7B9zx5HugCSsJtyxgMHc';
    var digest = sha1.convert(utf8.encode(signatureString));
    print(digest);
    var bytes = file.readAsBytesSync();
    var formData = FormData.fromMap({
      'file': bytes,
      'api_key': '685718363293648',
      'timestamp': time,
      'signature': digest
    }); 
    print(formData);
    var response = await Dio().post(
        'https://api.cloudinary.com/v1_1/quotenote/image/upload',
        data: formData);

    print(response.statusMessage);
    Map<String, dynamic> responseJson = json.decode(response.data);
    
    return responseJson['url'];
  }

  @override
  Widget build(BuildContext context) {
    File profilePic;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: CustomColors.white,
      bottomNavigationBar: AppBarBottom(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.white,
          title: AppBarProfile(
            user: _user,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Neumorphic(
                padding: const EdgeInsets.all(0),
                style: NeumorphicStyle(
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(60)),
                  depth: 3,
                  intensity: 1,
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height - 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CustomColors.primary,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height - 240,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: CustomColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                ),
                                Neumorphic(
                                  style: NeumorphicStyle(
                                    depth: 3,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.circle(),
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  child: ClipOval(
                                    child: widget._user.photoURL != null
                                        ? Image.network(
                                            widget._user.photoURL.toString(),
                                            scale: 1,
                                          )
                                        : Icon(
                                            Icons.person,
                                            color: CustomColors.darkGrey,
                                            size: 85,
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                // File picker
                                NeumorphicButton(
                                  onPressed: () async {
                                    File profilePic = await pickFile();
                                    String photoURL =
                                        await uploadToCloudinary(profilePic);
                                    _user.updateProfile(photoURL: photoURL);
                                  },
                                  style: NeumorphicStyle(
                                    depth: 3,
                                    intensity: 1,
                                    boxShape: NeumorphicBoxShape.circle(),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: ClipOval(
                                    child: Icon(
                                      Icons.edit,
                                      color: CustomColors.darkGrey,
                                      size: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  NeumorphicTextField(
                                    labelText: 'Name',
                                    icon: Icon(Icons.person_outline_rounded),
                                    controller: _nameController,
                                  ),
                                  SizedBox(height: 10),
                                  NeumorphicTextField(
                                    labelText: 'Email',
                                    icon: Icon(Icons.email),
                                    controller: _emailController,
                                  ),
                                  Button(
                                      text: 'Change Password',
                                      color: CustomColors.white,
                                      textColor: CustomColors.darkGrey,
                                      onPressed: () async {
                                        Authentication().resetPassword(
                                            context: context,
                                            emailAddress: widget._user.email);
                                      }),
                                  Button(
                                    text: 'Save',
                                    color: CustomColors.primary,
                                    textColor: CustomColors.white,
                                    onPressed: () async {
                                      User? user;

                                      if (user != null) {
                                        Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserInfoScreen(
                                              user: user,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
