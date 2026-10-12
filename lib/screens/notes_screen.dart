import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';
import '../services/notes_service.dart';
import '../widgets/note_input_dialog.dart';
import '../widgets/note_item.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> _notes = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final notes = await notesService.list();
      if (!mounted) return;
      setState(() => _notes = notes);
    } on AppwriteException catch (e) {
      if (!mounted) return;
      setState(() => _error = e.message ?? 'Could not load notes');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading && _notes.isEmpty) {
      body = const Center(child: CircularProgressIndicator());
    } else if (_error != null) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Text(_error!),
            FilledButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    } else {
      body = RefreshIndicator(
        onRefresh: _load,
        child: _notes.isEmpty
            ? ListView(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: Text('No notes yet.')),
                  ),
                ],
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  final note = _notes[index];
                  return NoteItem(
                    key: ValueKey(note.id),
                    note: note,
                    onEdit: () {},
                    onDelete: () {},
                  );
                },
              ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Notes')),
      body: body,
      // floatingActionButton unchanged for now
    );
  }
}