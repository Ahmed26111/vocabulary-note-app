import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_language_filter.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorted_filter.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorting_type.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/util/hive%20handler/hive_handler.dart';

part 'read_state.dart';

class ReadCubit extends Cubit<ReadState> {
  ReadCubit() : super(ReadInitialState());

  void updateLanguageFilter(EnLanguageFilter languageFilter){
    emit(ReadInitialState(words: state.words , languageFilter: languageFilter , sortingType: state.sortingType , sortedFilter: state.sortedFilter));
    getWords();
  }

  void updateSortedBy(EnSortedFilter sortedFilter){
    emit(ReadInitialState(words: state.words , sortedFilter: sortedFilter , languageFilter: state.languageFilter , sortingType: state.sortingType ));
    getWords();
  }

  void updateSortingType(EnSortingType sortingType){
    emit(ReadInitialState(words: state.words , sortingType: sortingType , languageFilter: state.languageFilter , sortedFilter: state.sortedFilter));
    getWords();
  }

  void getWords(){
    emit(ReadLoadingState(words: state.words,languageFilter: state.languageFilter,sortedFilter: state.sortedFilter,sortingType: state.sortingType));
    try{
      List<WordModel> wordsFromDataBase = HiveHandler.getWords();
      _removeTheUnwantedWordsFromTheList(wordsFromDataBase);
      _applySortingForTheList(wordsFromDataBase);
      emit(ReadLoadedState(words: wordsFromDataBase,languageFilter: state.languageFilter,sortedFilter: state.sortedFilter,sortingType: state.sortingType));
    }catch(error){
      emit(ReadErrorState(message: error.toString(),words: state.words,languageFilter: state.languageFilter,sortedFilter: state.sortedFilter,sortingType: state.sortingType));
    }
  }

  void _removeTheUnwantedWordsFromTheList(List<WordModel> words){
      if(state.languageFilter == EnLanguageFilter.eAll){return;}
      for(int i=0 ; i<words.length ; i++){
        if((state.languageFilter == EnLanguageFilter.eArabic && !words[i].isArabic) || (state.languageFilter == EnLanguageFilter.eEnglish && words[i].isArabic)){
          words.removeAt(i);
          i--;
        }
      }
  }

  void _applySortingForTheList(List<WordModel> words){
    if(state.sortedFilter == EnSortedFilter.eByTime){
      if(state.sortingType == EnSortingType.eAscending){
        return;
      }
      else{
        // We must reverse the list in place or replace content
        List<WordModel> reversed = words.reversed.toList();
        words.clear();
        words.addAll(reversed);
      }
    }
    else{
      words.sort((a,b)=>a.text.length.compareTo(b.text.length)); //sorted by word length ascending
      if(state.sortingType == EnSortingType.eAscending){
        return;
      }
      else{
        // We must reverse the list in place or replace content
        List<WordModel> reversed = words.reversed.toList();
        words.clear();
        words.addAll(reversed);
      }
    }

  }



}



