import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile{
  static Future<void> saveProfile(String email, String name,String tempURL, User _user) async {
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

  static Future<String> uploadToCloudinary(File file, CloudinaryPublic cloudinary) async {
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
      print(response.secureUrl);
    } on CloudinaryException catch (e) {
      print(e.message);
      print(e.request);
    }
    if (url != null) {
      return url;
    }
    return '';
  }

  static Future<File> pickFile() async {
    FilePickerResult result =
        (await FilePicker.platform.pickFiles(type: FileType.image))!;

    if (result.count > 0) {
      File file = File(result.files.single.path!);
      return file;
    } else {
      // User canceled the picker
      throw ("User cancelled file picker");
    }
  }
}