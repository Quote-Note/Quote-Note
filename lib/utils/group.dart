import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'note.dart';
import 'package:nanoid/nanoid.dart';


class Group {
  Key? key;
  String roomCode = '';
  String id = Uuid().v4();
  String type = 'No type';
  String name = 'No group';
  Color color = Colors.red;
  List<dynamic> adminIDs = <String>[];
  List<dynamic> memberIDs = <String>[];
  List<dynamic> noteIDs = [];

  Group({Key? key,required String id, required String type,required String roomCode, required String name,required Color color,required List<dynamic> adminIDs,required List<dynamic> noteIDs}) {
    this.key = UniqueKey();
    this.id = id;
    this.roomCode = customAlphabet('123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 6);
    this.type = type;
    this.name = name;
    this.color = color;
    this.adminIDs = adminIDs;
    this.noteIDs = noteIDs;
  }
}
