import 'dart:io';

import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'auth.dart';

late FirebaseStorage firebaseStorage = FirebaseStorage.instance;

class Profile{

  static void resetPassword({required BuildContext context, String? emailAddress}){
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.sendPasswordResetEmail(email: emailAddress!).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customFeedbackSnackBar(
              content: 'Sent a reset link to $emailAddress',
            ),
          );
    });
  }

  static Future<String> uploadToFirebase(BuildContext context, File file, String folder) async {

    String uId = FirebaseAuth.instance.currentUser!.uid;
    String fileName = basename(file.path);
    Reference reference = firebaseStorage.ref().child('$folder/$uId-${DateTime.now().millisecondsSinceEpoch}-$fileName'); // get a reference to the path of the image directory
    print('uploading to firebase');
    UploadTask uploadTask = reference.putFile(file); // put the file in the path
    TaskSnapshot result = await uploadTask.whenComplete(() => null); // wait for the upload to complete
    String url = await result.ref.getDownloadURL(); //retrieve the download link and return it
    return url;
  }

  static Future<File?> pickFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      // User canceled the picker
      return null;
    }
  }
}