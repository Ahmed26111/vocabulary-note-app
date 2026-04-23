import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/util/components/word_info_widget.dart';

class WordsDetailsScreen extends StatelessWidget {
  const WordsDetailsScreen({super.key, required this.wordModel});

  final WordModel wordModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getTheAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
          child: ListView(
            children: [
              _getWordDetailsLabel("Word"),
              SizedBox(height: MediaQuery.of(context).size.height*0.0125,),
              WordInfoWidget(
                  colorCodes: wordModel.colorCode,
                  text: wordModel.text,
                  isArabic: wordModel.isArabic,
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.025,),
              Row(
                spacing: 10,
                children: [
                  _getWordDetailsLabel("Similar Words"),
                  Spacer(),
                  _getUpdateWordButton(context: context , onPressed: (){}),
                ],
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.025,),
              Row(
                spacing: 10,
                children: [
                  _getWordDetailsLabel("Examples"),
                  Spacer(),
                  _getUpdateWordButton(context: context , onPressed: (){}),
                ],
              ),

            ],
          ),
        ),
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
    context.read<WriteCubit>().deleteWord(wordIndex: wordModel.indexAtDatabase);
    Navigator.pop(context);
  }

  Text _getWordDetailsLabel(String label) => Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Color(wordModel.colorCode[0]),
      ),
  );

  Container _getUpdateWordButton({required BuildContext context , required VoidCallback onPressed}) => Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.18,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: wordModel.colorCode.map((colorCode)=>Color(colorCode)).toList()),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.add,color: ColorsManager.black,)
  );


}

