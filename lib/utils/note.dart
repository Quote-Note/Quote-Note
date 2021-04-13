
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'group.dart';

class Note {
  Key? key;
  String title = 'Note';
  String note = '';
  String id = Uuid().v4();
  String authorID = 'No one';
  DateTime timestamp = DateTime.utc(2003, 03, 31);
  Group? group;
  String attachmentURL = '';

  Note({Key? key, required String id,required String title,required String body,required String authorID,required DateTime timestamp,required Group group, required String attachmentURL}) {
    this.key = UniqueKey();
    this.id = id;
    this.title = title;
    this.note = body;
    this.authorID = authorID;
    this.timestamp = timestamp;
    this.group = group;
    this.attachmentURL = attachmentURL;
  }
}