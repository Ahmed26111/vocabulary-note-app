import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/util/components/add_word_dialog.dart';
import 'package:vocabulary_note_app/util/components/colors_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: null,
      floatingActionButton: _getFloatingActionButton(context),
    );
  }

  FloatingActionButton _getFloatingActionButton(BuildContext context){
    return FloatingActionButton(
      onPressed: () => showDialog(context: context, builder: (context) => AddWordDialog()),
      backgroundColor: ColorsManager.white,
      foregroundColor: ColorsManager.black,
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }




}
