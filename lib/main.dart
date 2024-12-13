import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/main_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: AppEntry(),
    ),
  );
}

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick And Morty App',
      theme: ThemeData(),
      home: const MainPage(),
    );
  }
}
