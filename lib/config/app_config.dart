// lib/config/app_config.dart
/// Values injected at build time with --dart-define-from-file=env.json
class AppConfig {
  static const endpoint = String.fromEnvironment('APPWRITE_ENDPOINT');
  static const projectId = String.fromEnvironment('APPWRITE_PROJECT_ID');
  static const databaseId = String.fromEnvironment('APPWRITE_DATABASE_ID');
  static const tableId = String.fromEnvironment('APPWRITE_TABLE_ID');

  /// Fails early with a clear message when a value is missing.
  static void validate() {
    const values = {
      'APPWRITE_ENDPOINT': endpoint,
      'APPWRITE_PROJECT_ID': projectId,
      'APPWRITE_DATABASE_ID': databaseId,
      'APPWRITE_TABLE_ID': tableId,
    };
    final missing = values.entries.where((e) => e.value.isEmpty).map((e) => e.key);
    if (missing.isNotEmpty) {
      throw StateError(
        'Missing ${missing.join(', ')}. Run with --dart-define-from-file=env.json',
      );
    }
  }
}