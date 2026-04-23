import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/constants/index_validated_function.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/util/components/empty_word_widget.dart';
import 'package:vocabulary_note_app/util/components/error_word_widget.dart';
import 'package:vocabulary_note_app/util/components/update_word_dialog.dart';
import 'package:vocabulary_note_app/util/components/word_info_widget.dart';

class WordsDetailsScreen extends StatefulWidget {
  const WordsDetailsScreen({super.key, required this.wordModel});

  final WordModel wordModel;

  @override
  State<WordsDetailsScreen> createState() => _WordsDetailsScreenState();
}

class _WordsDetailsScreenState extends State<WordsDetailsScreen> {
  late  WordModel _wordModel;
  @override
  void initState(){
    super.initState();
    _wordModel = widget.wordModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getTheAppBar(context),
      body: BlocBuilder<ReadCubit, ReadState>(
          builder: (context, state) {
            if (state is ReadLoadedState) {
              int index = state.words.indexWhere((word) => (word.indexAtDatabase == _wordModel.indexAtDatabase));
              if(isIndexValidated(index, state.words)){
                _wordModel = state.words[index]; //? get the last update in word model
                return _getLoadedBody(context);
              }
              return EmptyWordWidget();
            }
            else if (state is ReadErrorState){
              return ErrorWordWidget(message: state.message);
            }
            return Center(child: CircularProgressIndicator(color: Color(_wordModel.colorCode[0]),));
          }
      ),
    );

  }

  Padding _getLoadedBody(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                child: ListView(
                  children: [
                    _getWordDetailsLabel("Word"),
                    SizedBox(height: MediaQuery.of(context).size.height*0.0125,),
                    WordInfoWidget(
                        colorCodes: _wordModel.colorCode,
                        text: _wordModel.text,
                        isArabic: _wordModel.isArabic,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                    Row(
                      spacing: 10,
                      children: [
                        _getWordDetailsLabel("Similar Words"),
                        Spacer(),
                        _getUpdateWordButton(
                          context: context,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => UpdateWordDialog(
                              isExample: false,
                              colorCodes: _wordModel.colorCode,
                              wordIndex: _wordModel.indexAtDatabase,
                            ),
                          ),
                      ),
                      ],
                    ),
                    ..._getArabicSimilaritesWordInfo(context),
                    ..._getEnglishSimilaritesWordInfo(context),
                    SizedBox(height: MediaQuery.of(context).size.height*0.025,),
                    Row(
                      spacing: 10,
                      children: [
                        _getWordDetailsLabel("Examples"),
                        Spacer(),
                        _getUpdateWordButton(context: context , onPressed: () => showDialog(
                          context: context,
                          builder: (context) => UpdateWordDialog(
                            isExample: true,
                            colorCodes: _wordModel.colorCode,
                            wordIndex: _wordModel.indexAtDatabase,
                          ),
                        ),),
                      ],
                    ),
                    ..._getArabicExamplesWordInfo(context),
                    ..._getEnglishExampleWordInfo(context),
                  ],
                ),
    );
  }

  AppBar _getTheAppBar(BuildContext context) => AppBar(
    foregroundColor: Color(_wordModel.colorCode[0]),
    title: Text(
      "Word Details",
      style: TextStyle(
        color: Color(_wordModel.colorCode[0]),
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
    context.read<WriteCubit>().deleteWord(wordIndex: _wordModel.indexAtDatabase);
    Navigator.pop(context);
  }

  Text _getWordDetailsLabel(String label) => Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
        color: Color(_wordModel.colorCode[0]),
      ),
  );

  InkWell _getUpdateWordButton({required BuildContext context , required VoidCallback onPressed}) => InkWell(
    borderRadius: BorderRadius.circular(10),
    onTap: onPressed,
    child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.18,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: _wordModel.colorCode.map((colorCode)=>Color(colorCode)).toList()),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add,color: ColorsManager.black,)
    ),
  );

  List<Widget> _getArabicSimilaritesWordInfo(BuildContext context){
    List<Widget> widgets = [];
    for(int i =0 ; i< _wordModel.arabicSimilarites.length ; i++){
      widgets.add(SizedBox(height: MediaQuery.of(context).size.height*0.0125,),);
      widgets.add(WordInfoWidget(colorCodes: _wordModel.colorCode,
        text: _wordModel.arabicSimilarites[i],
        isArabic: true,
        showDeleteButton: true,
        onPressed: () {
          context.read<WriteCubit>().deleteSimilarWord(wordIndex: _wordModel.indexAtDatabase, similarWordIndex: i, isArabicSimilarWord: true);
          context.read<ReadCubit>().getWords();
        },
      ));
    }
    return widgets;
  }

  List<Widget> _getEnglishSimilaritesWordInfo(BuildContext context){
    List<Widget> widgets = [];
    for(int i =0 ; i< _wordModel.englishSimilarites.length ; i++){
      widgets.add(SizedBox(height: MediaQuery.of(context).size.height*0.0125,),);
      widgets.add(WordInfoWidget(colorCodes: _wordModel.colorCode,
        text: _wordModel.englishSimilarites[i],
        isArabic: false,
        showDeleteButton: true,
        onPressed: () {
          context.read<WriteCubit>().deleteSimilarWord(wordIndex: _wordModel.indexAtDatabase, similarWordIndex: i, isArabicSimilarWord: false);
          context.read<ReadCubit>().getWords();
        },
      ));
    }
    return widgets;
  }

  List<Widget> _getArabicExamplesWordInfo(BuildContext context){
    List<Widget> widgets = [];
    for(int i =0 ; i< _wordModel.arabicExamples.length ; i++){
      widgets.add(SizedBox(height: MediaQuery.of(context).size.height*0.0125,),);
      widgets.add(WordInfoWidget(colorCodes: _wordModel.colorCode,
        text: _wordModel.arabicExamples[i],
        isArabic: true,
        showDeleteButton: true,
        onPressed: () {
          context.read<WriteCubit>().deleteExample(wordIndex: _wordModel.indexAtDatabase, exampleIndex: i, isArabicExample: true);
          context.read<ReadCubit>().getWords();
        },
      ));
    }
    return widgets;
  }

  List<Widget> _getEnglishExampleWordInfo(BuildContext context){
    List<Widget> widgets = [];
    for(int i =0 ; i< _wordModel.englishExamples.length ; i++){
      widgets.add(SizedBox(height: MediaQuery.of(context).size.height*0.0125,),);
      widgets.add(WordInfoWidget(colorCodes: _wordModel.colorCode,
        text: _wordModel.englishExamples[i],
        isArabic: false,
        showDeleteButton: true,
        onPressed: () {
          context.read<WriteCubit>().deleteExample(wordIndex: _wordModel.indexAtDatabase, exampleIndex: i, isArabicExample: false);
          context.read<ReadCubit>().getWords();
        },
      ));
    }
    return widgets;
  }
}

