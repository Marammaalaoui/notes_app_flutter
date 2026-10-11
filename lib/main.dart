import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';
import 'screens/notes_screen.dart';

void main() => runApp(const NotesApp());

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/notes', builder: (context, state) => const NotesScreen()),
  ],
);

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Notes App',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF208AEF)),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF208AEF),
        brightness: Brightness.dark,
      ),
      routerConfig: _router,
    );
  }
}