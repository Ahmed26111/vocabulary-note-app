import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/util/hive%20handler/hive_handler.dart';

part 'write_state.dart';

class WriteCubit extends Cubit<WriteState> {
  WriteCubit() : super(WriteInitialState());

  void updateText(String text){
    emit(WriteLoadedState(text: text,isArabic: state.isArabic,colorCode: state.colorCode));
  }

  void updateIsArabic(bool isArabic){
    emit(WriteLoadedState(text: state.text,isArabic: isArabic,colorCode: state.colorCode));
  }

  void updateColorCode(int colorCode){
    emit(WriteLoadedState(text: state.text,isArabic: state.isArabic,colorCode: colorCode));
  }

  void addWord(){
    _tryAndCatchBlock(()
    {
      List<WordModel>wordsFromDatabase = HiveHandler.getWords();
      wordsFromDatabase.add(WordModel(indexAtDatabase: wordsFromDatabase.length, colorCode: state.colorCode, text: state.text, isArabic: state.isArabic));
      HiveHandler.addAndUpdateWords(wordsFromDatabase);
    },
    );
  }

  void deleteWord(int index){
    _tryAndCatchBlock(()
      {
        List<WordModel>wordsFromDatabase = HiveHandler.getWords();
        wordsFromDatabase.removeAt(index);
        wordsFromDatabase = wordsFromDatabase.map((word) {
          word = word.decrementIndexAtDataBase();
        }).toList().cast<WordModel>();
        HiveHandler.addAndUpdateWords(wordsFromDatabase);
      },
    );
  }

  void _tryAndCatchBlock(VoidCallback methodToExecute ){
    emit(WriteLoadingState(text: state.text,isArabic: state.isArabic,colorCode: state.colorCode));
    try{
      methodToExecute.call();
      emit(WriteLoadedState(text: state.text,isArabic: state.isArabic,colorCode: state.colorCode));
    } catch(error){
      emit(WriteErrorState(message: error.toString(),text: state.text,isArabic: state.isArabic,colorCode: state.colorCode));
    }
  }

}
