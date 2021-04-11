import 'package:flutter/material.dart';
import 'note.dart';
import 'package:nanoid/nanoid.dart';


class Group {
  Key? key;
  String roomCode = '';
  String type = 'No type';
  String name = 'No group';
  Color color = Colors.red;
  List<String> admins = ['No Admins'];
  List<Note> notes = List<Note>.empty();

  Group({Key? key, required String type,required String name,required Color color,required List<String> admins,required List<Note> notes}) {
    this.key = UniqueKey();
    this.roomCode = customAlphabet('123456789abcdefghijklmnopqrstuvwxyz', 6);
    this.type = type;
    this.name = name;
    this.color = color;
    this.admins = admins;
    this.notes = notes;
  }

  String getRoomCode(){
    return roomCode;
  }
}
