
import 'package:flutter/material.dart';

class Note {
  Key? key;
  String title = 'Note';
  String note = '';
  String author = 'No one';
  DateTime timestamp = DateTime.utc(2021, 03, 31);
  String? attachmentURL;

  Note({Key? key, required String title,required String body,required String author,required DateTime timestamp, String? attachmentURL}) {
    this.key = UniqueKey();
    this.title = title;
    this.note = body;
    this.author = author;
    this.timestamp = timestamp;
    this.attachmentURL = attachmentURL;
  }
}