import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> WriteCubit()) ,
        BlocProvider(create: (context)=> ReadCubit()) ,
      ],
      child: MaterialApp(
        home: const HomeScreen(),
        theme: ThemeManager.getLightAppTheme(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
