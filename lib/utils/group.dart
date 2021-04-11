import 'package:flutter/material.dart';
import 'note.dart';

class Group {
  Key? key;
  String type = 'No type';
  String name = 'No group';
  Color color = Colors.red;
  List<String> admins = ['No Admins'];
  List<Note> notes = List<Note>.empty();

  Group({Key? key,required String type,required String name,required Color color,required List<String> admins,required List<Note> notes}) {
    this.key = UniqueKey();
    this.type = type;
    this.name = name;
    this.color = color;
    this.admins = admins;
    this.notes = notes;
  }
}
