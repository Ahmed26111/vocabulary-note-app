import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vocabulary_note_app/constants/index_validated_function.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/util/hive%20handler/hive_handler.dart';

part 'write_state.dart';

class WriteCubit extends Cubit<WriteState> {
  WriteCubit() : super(WriteInitialState());

  void updateText(String text){
    emit(WriteInitialState(text: text,isArabic: state.isArabic,colorCodes: state.colorCodes));
  }

  void updateIsArabic(bool isArabic){
    emit(WriteInitialState(text: state.text,isArabic: isArabic,colorCodes: state.colorCodes));
  }

  void updateColorCode(List<int> colorsCode){
    emit(WriteInitialState(text: state.text,isArabic: state.isArabic,colorCodes: colorsCode));
  }

  void addWord(){
    _tryAndCatchBlock(()
    {
      List<WordModel>wordsFromDatabase = HiveHandler.getWords();
      wordsFromDatabase.add(WordModel(indexAtDatabase: wordsFromDatabase.length, colorCode: state.colorCodes, text: state.text, isArabic: state.isArabic));
      HiveHandler.addAndUpdateWords(wordsFromDatabase);
    },
    );
  }

  void deleteWord({required int wordIndex}){
    _tryAndCatchBlock(()
      {
        List<WordModel>wordsFromDatabase = HiveHandler.getWords();
        if(isIndexValidated(wordIndex, wordsFromDatabase)){
            wordsFromDatabase.removeAt(wordIndex);
            for(int i=wordIndex;i<wordsFromDatabase.length;i++){
              wordsFromDatabase[i] = wordsFromDatabase[i].decrementIndexAtDataBase();
            }
        }
        else{
          throw Exception("this index is not valid");
        }
        HiveHandler.addAndUpdateWords(wordsFromDatabase);
      },
    );
  }

  void addSimilarWord({required int wordIndex}){
    _tryAndCatchBlock(
        (){
          List<WordModel> wordsFromDatabase = HiveHandler.getWords();
          if(isIndexValidated(wordIndex, wordsFromDatabase)){
            wordsFromDatabase[wordIndex] = wordsFromDatabase[wordIndex].addSimilarWord(state.text, state.isArabic);
          }
          else{
            throw Exception("this index is not valid");
          }
          HiveHandler.addAndUpdateWords(wordsFromDatabase);
        },
    );
  }

  void deleteSimilarWord({required int wordIndex,required int similarWordIndex,required bool isArabicSimilarWord}){
    _tryAndCatchBlock(
          (){
        List<WordModel> wordsFromDatabase = HiveHandler.getWords();
        if(isIndexValidated(wordIndex, wordsFromDatabase)){
          if ((isArabicSimilarWord)
              ? isIndexValidated(
              similarWordIndex, wordsFromDatabase[wordIndex].arabicSimilarites)
              : isIndexValidated(
              similarWordIndex, wordsFromDatabase[wordIndex].englishSimilarites)
          ) {
            wordsFromDatabase[wordIndex] =
                wordsFromDatabase[wordIndex].deleteSimilarWord(
                    similarWordIndex, isArabicSimilarWord);
          }
          else {
            throw Exception("this similar word index is not valid");
          }
        }
        else{
          throw Exception("this word index is not valid");
        }
        HiveHandler.addAndUpdateWords(wordsFromDatabase);
      },
    );
  }

  void addExample({required int wordIndex}){
    _tryAndCatchBlock(
          (){
        List<WordModel> wordsFromDatabase = HiveHandler.getWords();
        if(isIndexValidated(wordIndex, wordsFromDatabase)){
          wordsFromDatabase[wordIndex] = wordsFromDatabase[wordIndex].addExample(state.text, state.isArabic);
        }
        else{
          throw Exception("this index is not valid");
        }
        HiveHandler.addAndUpdateWords(wordsFromDatabase);
      },
    );
  }

  void deleteExample({required int wordIndex,required int similarWordIndex , required bool isArabicExample}){
    _tryAndCatchBlock(
          (){
        List<WordModel> wordsFromDatabase = HiveHandler.getWords();
        if(isIndexValidated(wordIndex, wordsFromDatabase)){
          if ((isArabicExample)
              ? isIndexValidated(
              similarWordIndex, wordsFromDatabase[wordIndex].arabicExamples)
              : isIndexValidated(
              similarWordIndex, wordsFromDatabase[wordIndex].englishExamples)
          ) {
            wordsFromDatabase[wordIndex] =
                wordsFromDatabase[wordIndex].deleteExample(
                    similarWordIndex, isArabicExample);
          }
          else {
            throw Exception("this example index is not valid");
          }
        }
        else{
          throw Exception("this word index is not valid");
        }
        HiveHandler.addAndUpdateWords(wordsFromDatabase);
      },
    );
  }

  void _tryAndCatchBlock(void Function () methodToExecute  ){
    emit(WriteLoadingState(text: state.text,isArabic: state.isArabic,colorCodes: state.colorCodes));
    try{
      methodToExecute.call();
      emit(WriteLoadedState(text: state.text,isArabic: state.isArabic,colorCodes: state.colorCodes));
    } catch(error){
      emit(WriteErrorState(message: error.toString(),text: state.text,isArabic: state.isArabic,colorCodes: state.colorCodes));
    }
  }

}
