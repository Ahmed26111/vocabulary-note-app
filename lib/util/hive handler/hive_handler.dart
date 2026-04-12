
import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_note_app/constants/hive_constants.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_type_adapter.dart';

class HiveHandler{
  static late Box box;

  static Future<void> init() async{
    await Hive.initFlutter();
    Hive.registerAdapter(WordTypeAdapter());
    box = await Hive.openBox<List<WordModel>>(HiveConstants.wordsBox);
  }

  static List<WordModel> getWords(){
    return List<WordModel>.from(box.get(HiveConstants.wordsList, defaultValue: []));
  }

}