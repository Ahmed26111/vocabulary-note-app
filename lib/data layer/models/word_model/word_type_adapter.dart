import 'package:hive_flutter/adapters.dart';
import 'package:vocabulary_note_app/data%20layer/models/word_model/word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel>{
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
        indexAtDatabase: reader.readInt(),
        colorCode: reader.readIntList(),
        text: reader.readString(),
        isArabic: reader.readBool(),
        arabicSimilarites: reader.readStringList(),
        englishSimilarites: reader.readStringList(),
        arabicExamples: reader.readStringList(),
        englishExamples: reader.readStringList(),
    );
  }

  @override
  int get typeId => 0; //? 0-223

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexAtDatabase);
    writer.writeIntList(obj.colorCode);
    writer.writeString(obj.text);
    writer.writeBool(obj.isArabic);
    writer.writeStringList(obj.arabicSimilarites);
    writer.writeStringList(obj.englishSimilarites);
    writer.writeStringList(obj.arabicExamples);
    writer.writeStringList(obj.englishExamples);
  }



}