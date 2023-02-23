import 'package:flutter/material.dart';
import '/routes/router.dart';
import '/core/core.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter firestore',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
