import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/util/components/empty_word_widget.dart';
import 'package:vocabulary_note_app/util/components/error_word_widget.dart';
import 'package:vocabulary_note_app/util/components/word_item_widget.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCubit,ReadState>(
        builder: (context,state){
          switch(state){

            case ReadInitialState():
            case ReadLoadingState():return _getLoadingWidget();

            case ReadLoadedState():return (state.words.isEmpty)?_getEmptyWordsWidget():_getWordsWidget(state.words);

            case ReadErrorState():return _getErrorWidget(state.message);
          }
        }
    );
  }

  Widget _getLoadingWidget(){
    return CircularProgressIndicator(color: ColorsManager.white,);
  }

  Widget _getErrorWidget(String message){
    return  ErrorWordWidget(message: message,);
  }

  Widget _getEmptyWordsWidget(){
    return  EmptyWordWidget();
  }

  Widget _getWordsWidget(List<WordModel> words){
    return  Expanded(
      child: GridView.builder(
          itemCount: words.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 2/1.8
          ),
          itemBuilder: (context , index)=>WordItemWidget(wordModel: words[index]),
      ),
    );
  }

}
