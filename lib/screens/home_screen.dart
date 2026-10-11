// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Notes App')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            Text('Notes App', style: textTheme.headlineLarge),
            const Text('Flutter + go_router'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go('/notes'),
              child: const Text('Open my notes →'),
            ),
          ],
        ),
      ),
    );
  }
}