import 'package:flutter/material.dart';

import '../models/note.dart';
import '../widgets/note_input_dialog.dart';
import '../widgets/note_item.dart';

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

  Future<void> _add() async {
    final draft = await showNoteInputDialog(context);
    if (draft == null) return;
    setState(() {
      _notes.insert(
        0,
        Note(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: draft.title,
          content: draft.content,
        ),
      );
    });
  }

  Future<void> _edit(Note note) async {
    final draft = await showNoteInputDialog(context, initial: note);
    if (draft == null) return;
    setState(() {
      final index = _notes.indexWhere((n) => n.id == note.id);
      _notes[index] = note.copyWith(title: draft.title, content: draft.content);
    });
  }

  void _delete(String id) => setState(() => _notes.removeWhere((n) => n.id == id));

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
                return NoteItem(
                  key: ValueKey(note.id),
                  note: note,
                  onEdit: () => _edit(note),
                  onDelete: () => _delete(note.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        tooltip: 'Add note',
        child: const Icon(Icons.add),
      ),
    );
  }
}