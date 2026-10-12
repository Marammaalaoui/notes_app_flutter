import 'package:appwrite/appwrite.dart';

import '../config/app_config.dart';
import '../models/note.dart';
import 'appwrite_client.dart';

class NotesService {
  NotesService(this._db);

  final TablesDB _db;

  Future<List<Note>> list() async {
    final result = await _db.listRows(
      databaseId: AppConfig.databaseId,
      tableId: AppConfig.tableId,
      queries: [Query.orderDesc('\$createdAt')],
    );
    return result.rows.map(Note.fromRow).toList();
  }

  Future<Note> create(NoteDraft draft) async {
    final row = await _db.createRow(
      databaseId: AppConfig.databaseId,
      tableId: AppConfig.tableId,
      rowId: ID.unique(),
      data: {'title': draft.title, 'content': draft.content},
    );
    return Note.fromRow(row);
  }

  Future<Note> update(String id, NoteDraft draft) async {
    final row = await _db.updateRow(
      databaseId: AppConfig.databaseId,
      tableId: AppConfig.tableId,
      rowId: id,
      data: {'title': draft.title, 'content': draft.content},
    );
    return Note.fromRow(row);
  }

  Future<void> delete(String id) async {
    await _db.deleteRow(
      databaseId: AppConfig.databaseId,
      tableId: AppConfig.tableId,
      rowId: id,
    );
  }
}

final notesService = NotesService(tablesDB);