import 'package:vocabulary_note_app/constants/index_validated_function.dart';

class WordModel {
  final int indexAtDatabase;
  final List<int> colorCode;
  final String text;
  final bool isArabic;
  final List<String> arabicSimilarites;
  final List<String> englishSimilarites;
  final List<String> arabicExamples;
  final List<String> englishExamples;

  const WordModel({
    required this.indexAtDatabase,
    required this.colorCode,
    required this.text,
    required this.isArabic,
    this.arabicSimilarites = const [],
    this.englishSimilarites = const [],
    this.arabicExamples = const [],
    this.englishExamples = const [],
  });

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _initializeNewSimilarWords(
      isArabicSimilarWord,
    );
    newSimilarWords.add(similarWord);
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel deleteSimilarWord(int indexAtSimilarWord, bool isArabicSimilarWord,) {
    List<String> newSimilarWords = _initializeNewSimilarWords(
      isArabicSimilarWord,
    );
    if(isIndexValidated(indexAtSimilarWord, newSimilarWords)){
       newSimilarWords.removeAt(indexAtSimilarWord);
    }
    return _getWordAfterCheckSimilarWords(newSimilarWords, isArabicSimilarWord);
  }

  WordModel addExample(String example, bool isArabicExample) {
    List<String> newExample = _initializeNewExample(isArabicExample);
    newExample.add(example);
    return _getWordAfterCheckExamples(newExample, isArabicExample);
  }

  WordModel deleteExample(int indexAtExample, bool isArabicExample) {
    List<String> newExample = _initializeNewExample(isArabicExample);
    if(isIndexValidated(indexAtExample, newExample)){
      newExample.removeAt(indexAtExample);
    }
    return _getWordAfterCheckExamples(newExample, isArabicExample);
  }

  WordModel decrementIndexAtDataBase() {
    return copyWith(
      newIndexAtDataBase: indexAtDatabase - 1 ,
    );
  }

  WordModel copyWith(
      {int ? newIndexAtDataBase, List<int> ? newColorCode, String ? newText, bool ? newIsArabic, List<
          String> ? newArabicSimilarites, List<String> ? newEnglishSimilarites, List<
          String> ? newArabicExamples, List<String> ? newEnglishExamples})
  {
    return WordModel(
        indexAtDatabase: newIndexAtDataBase ?? indexAtDatabase,
        colorCode: newColorCode ?? colorCode,
        text: newText ?? text,
        isArabic: newIsArabic ?? isArabic ,
        arabicSimilarites: newArabicSimilarites ?? arabicSimilarites ,
        englishSimilarites: newEnglishSimilarites ?? englishSimilarites ,
        arabicExamples: newArabicExamples ?? arabicExamples,
        englishExamples: newEnglishExamples ?? englishExamples
    );
  }

  List<String> _initializeNewSimilarWords(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      //? when you use the List.from() it will copy the values from the final to the non final list
      return List.from(arabicSimilarites);
      //! temp = arabicSimilarites this will make temp also final because it will reference it
    } else {
      //? when you use the List.from() it will copy the values from the final to the non final list
      return List.from(englishSimilarites);
      //! temp = englishSimilarites this will make temp also final because it will reference it
    }
  }

  WordModel _getWordAfterCheckSimilarWords(List<String> newSimilarWords, bool isArabicSimilarWord,) {
    return copyWith(
      newArabicSimilarites: (isArabicSimilarWord)
          ? newSimilarWords
          : null,
      newEnglishSimilarites: (!isArabicSimilarWord)
          ? newSimilarWords
          : null,
    );
  }

  List<String> _initializeNewExample(bool isArabicExample) {
    if (isArabicExample) {
      return List.from(arabicExamples);
    } else {
      return List.from(englishExamples);
    }
  }

  WordModel _getWordAfterCheckExamples(List<String> newExamples, bool isArabicExample,) {
    return copyWith(
      newArabicExamples: (isArabicExample) ? newExamples : null,
      newEnglishExamples: (!isArabicExample) ? newExamples : null,
    );
  }
}
