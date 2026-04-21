import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.wordModel});

  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getWordDecoration(),
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          wordModel.text,
          style: TextStyle(
            color: ColorsManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 20
          ),
        ),
      ),
    );
  }

  BoxDecoration _getWordDecoration(){
    return BoxDecoration(
      gradient: LinearGradient(colors: wordModel.colorCode.map((colorCode)=>Color(colorCode)).toList()),
      borderRadius: BorderRadius.circular(12),
    );
  }

}
