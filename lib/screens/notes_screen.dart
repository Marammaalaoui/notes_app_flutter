// lib/screens/notes_screen.dart
import 'package:flutter/material.dart';

import '../models/note.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Note> _notes = [
    const Note(id: '1', title: 'Welcome', content: 'Tap + to add a note.'),
    const Note(id: '2', title: 'Shopping', content: 'Milk, bread, coffee.'),
  ];

  Future<void> _showNoteDialog({Note? note}) async {
    final titleController = TextEditingController(text: note?.title);
    final contentController = TextEditingController(text: note?.content);

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'New note' : 'Edit note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    final title = titleController.text.trim();
    final content = contentController.text.trim();
    // NOTE: these controllers are never disposed here. Disposing them right
    // after the dialog closes would crash, because the closing animation still
    // uses them. We fix this properly in section 5.4.

    if (saved != true || title.isEmpty) return;

    setState(() {
      if (note == null) {
        _notes.insert(
          0,
          Note(id: DateTime.now().microsecondsSinceEpoch.toString(), title: title, content: content),
        );
      } else {
        final index = _notes.indexWhere((n) => n.id == note.id);
        _notes[index] = note.copyWith(title: title, content: content);
      }
    });
  }

  void _deleteNote(String id) {
    setState(() => _notes.removeWhere((n) => n.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: _notes.isEmpty
          ? const Center(child: Text('No notes yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  key: ValueKey(note.id),
                  child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.content, maxLines: 2, overflow: TextOverflow.ellipsis),
                    onTap: () => _showNoteDialog(note: note),
                    trailing: IconButton(
                      tooltip: 'Delete ${note.title}',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteNote(note.id),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(),
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}