import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class Profile{
  /* static Future<void> saveProfile(String email, String name,String tempURL, User _user) async {
    if (email != '') {
      await _user.updateEmail(email).then((value) => _user.reload());
    }
    
    if (name != '') {
      await _user.updateProfile(displayName: name);
    }

    await _user.updateProfile(photoURL: tempURL).then((value) async {
      await _user
          .reload()
          .then((value) => {imageCache!.clear()})
          .then((value) => {imageCache!.clearLiveImages()})
          .then((value) => {_user = FirebaseAuth.instance.currentUser!});
    });
  }
 */

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

  static Future<String> uploadToCloudinary(BuildContext context, File file, CloudinaryPublic cloudinary) async {
    String? url;
    try {
      CloudinaryResponse? response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file.path,
            resourceType: CloudinaryResourceType.Image),
      );
      CloudinaryImage image = CloudinaryImage(response.secureUrl);
      // Image optimisation
      url = image
          .transform()
          .width(200)
          .quality('auto:eco')
          .crop('limit')
          .generate();

      ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customFeedbackSnackBar(
              content: 'Uploaded profile picture',
            ),
          );
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
      ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customErrorSnackBar(
              content: e.message!,
            ),
          );
    }
    if (url != null) {
      return url;
    }
    
    return '';
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