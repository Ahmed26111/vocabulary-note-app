import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/ui%20layer/core/layout/home_screen.dart';
import 'package:vocabulary_note_app/ui%20layer/core/theme/theme_manager.dart';
import 'package:vocabulary_note_app/util/hive%20handler/hive_handler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHandler.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeManager.getLightAppTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
