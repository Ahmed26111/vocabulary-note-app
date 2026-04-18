import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_language_filter.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCubit,ReadState>(
        builder: (context,state)=>Text(
          convertEnumFilterToString(state.languageFilter),
          style: TextStyle(
            color: ColorsManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 21
          ),
        )
    );
  }

  String convertEnumFilterToString(EnLanguageFilter languageFilter){
      switch(languageFilter){
        case EnLanguageFilter.eArabic: return "Arabic Only";
        case EnLanguageFilter.eEnglish:return "English Only";
        case EnLanguageFilter.eAll:return "All Words";
      }
  }
}
