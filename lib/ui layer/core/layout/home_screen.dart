import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/util/components/add_word_dialog.dart';
import 'package:vocabulary_note_app/util/components/colors_widget.dart';
import 'package:vocabulary_note_app/util/components/filter_dialog_button.dart';
import 'package:vocabulary_note_app/util/components/language_filter_widget.dart';
import 'package:vocabulary_note_app/util/components/words_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          spacing: 5,
          children: [
            Row(
              children: [
                LanguageFilterWidget(),
                Spacer(),
                FilterDialogButton(),
              ],
            ),
            BlocListener<WriteCubit, WriteState>(
              listener: (context, state) {
                if(state is WriteLoadedState){
                  context.read<ReadCubit>().getWords();
                }
              },
              child: WordsWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: _getFloatingActionButton(context),
    );
  }

  FloatingActionButton _getFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () =>
          showDialog(context: context, builder: (context) => AddWordDialog()),
      backgroundColor: ColorsManager.white,
      foregroundColor: ColorsManager.black,
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }


}
