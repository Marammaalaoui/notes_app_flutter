/// Immutable data class: to change a note, create a copy.
class Note {
  const Note({required this.id, required this.title, required this.content});

  final String id;
  final String title;
  final String content;

  Note copyWith({String? title, String? content}) =>
      Note(id: id, title: title ?? this.title, content: content ?? this.content);
}

/// Title and content typed by the user, before an id is assigned.
typedef NoteDraft = ({String title, String content});