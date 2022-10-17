import 'package:flutter/material.dart';
import 'package:flutter_app_note/utils/theme_constants.dart';

import 'modules/home/pages/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: notesTheme,
      title: "Notes Keeper",
      home: const HomeApp(),
    );
  }
}
