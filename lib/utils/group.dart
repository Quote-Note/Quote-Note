import 'package:flutter/material.dart';

import 'note.dart';

class Group {
  String type = 'No type';
  String name = 'No group';
  Color color = Colors.red;
  List<String> admins = ['No Admins'];
  List<Note> notes = [];

  Group(String type, String name, Color color, List<String> admins, List<Note> notes) {
    this.type = type;
    this.name = name;
    this.color = color;
    this.admins = admins;
  }
}