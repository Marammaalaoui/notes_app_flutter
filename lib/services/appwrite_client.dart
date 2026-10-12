// lib/services/appwrite_client.dart
import 'package:appwrite/appwrite.dart';

import '../config/app_config.dart';

final Client client = Client()
    .setEndpoint(AppConfig.endpoint)
    .setProject(AppConfig.projectId);

final TablesDB tablesDB = TablesDB(client);
final Account account = Account(client);