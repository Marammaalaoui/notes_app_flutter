// "Row" is also the name of a Flutter widget, so we import the models with a prefix.
import 'package:appwrite/models.dart' as models;

class Note {
  const Note({required this.id, required this.title, required this.content});

  factory Note.fromRow(models.Row row) => Note(
        id: row.$id,
        title: row.data['title'] as String,
        content: (row.data['content'] as String?) ?? '',
      );

  final String id;
  final String title;
  final String content;

  Note copyWith({String? title, String? content}) =>
      Note(id: id, title: title ?? this.title, content: content ?? this.content);
}

/// Title and content typed by the user, before an id is assigned.
typedef NoteDraft = ({String title, String content});