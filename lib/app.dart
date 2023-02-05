import 'package:flutter/material.dart';
import '/views/views.dart';
import '/core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter firestore',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
