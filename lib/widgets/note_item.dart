import 'package:flutter/material.dart';

import '../models/note.dart';

class NoteItem extends StatelessWidget {
  const NoteItem({
    super.key,
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(note.title),
        subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
        onTap: onEdit,
        trailing: IconButton(
          tooltip: 'Delete ${note.title}',
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
        ),
      ),
    );
  }
}