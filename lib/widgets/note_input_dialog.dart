import 'package:flutter/material.dart';

import '../models/note.dart';

/// Shows the dialog and returns the draft, or null if the user cancelled.
Future<NoteDraft?> showNoteInputDialog(BuildContext context, {Note? initial}) {
  return showDialog<NoteDraft>(
    context: context,
    builder: (_) => _NoteInputDialog(initial: initial),
  );
}

class _NoteInputDialog extends StatefulWidget {
  const _NoteInputDialog({this.initial});

  final Note? initial;

  @override
  State<_NoteInputDialog> createState() => _NoteInputDialogState();
}

class _NoteInputDialogState extends State<_NoteInputDialog> {
  late final _title = TextEditingController(text: widget.initial?.title);
  late final _content = TextEditingController(text: widget.initial?.content);

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.initial == null ? 'New note' : 'Edit note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          TextField(
            controller: _title,
            decoration: const InputDecoration(labelText: 'Title'),
            onChanged: (_) => setState(() {}), // re-evaluate the Save button
          ),
          TextField(
            controller: _content,
            decoration: const InputDecoration(labelText: 'Content'),
            maxLines: 4,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          // null disables the button
          onPressed: _title.text.trim().isEmpty
              ? null
              : () => Navigator.pop(
                    context,
                    (title: _title.text.trim(), content: _content.text.trim()),
                  ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}