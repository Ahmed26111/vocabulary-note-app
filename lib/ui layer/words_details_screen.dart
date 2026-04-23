import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';

class WordsDetailsScreen extends StatelessWidget {
  const WordsDetailsScreen({super.key, required this.wordModel});

  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getTheAppBar(context),

    );
  }

  AppBar _getTheAppBar(BuildContext context) => AppBar(
    foregroundColor: Color(wordModel.colorCode[0]),
    title: Text(
      "Word Details",
      style: TextStyle(
        color: Color(wordModel.colorCode[0]),
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    ),
    actions: [
      IconButton(
        onPressed: ()=>_deleteWord(context),
        icon: Icon(Icons.delete, size: 25,),
      ),
    ],
  );

  void _deleteWord(BuildContext context){
    context.read<WriteCubit>().deleteWord(wordIndex: 0);
    Navigator.pop(context);
  }
}

