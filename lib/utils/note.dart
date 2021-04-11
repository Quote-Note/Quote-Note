class Note {
  String title = 'Note';
  String note = '';
  String author = 'No one';
  DateTime timestamp = DateTime.utc(2021, 03, 31);

  Note(String title, String body, String author, DateTime timestamp) {
    this.title = title;
    this.note = body;
    this.author = author;
    this.timestamp = timestamp;
  }
}