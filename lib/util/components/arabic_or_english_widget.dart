import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget({super.key, required this.colorCodes, required this.isArabicSelected});

  final List<int> colorCodes;
  final bool isArabicSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
        spacing: 10,
        children: [
          _getLanguageItemContainer(true,context), //? get Arabic container
          _getLanguageItemContainer(false,context),//? get English container
        ]
    );
  }

  Widget _getLanguageItemContainer(bool isArabicBuild , BuildContext context){
    return InkWell(
      onTap: ()=> BlocProvider.of<WriteCubit>(context).updateIsArabic(isArabicBuild),
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (isArabicSelected == isArabicBuild)?ColorsManager.white:null,
          gradient: (isArabicSelected == isArabicBuild)? null :LinearGradient(colors: colorCodes.map((colorCode)=>Color(colorCode)).toList()),
          border: !(isArabicSelected == isArabicBuild)? Border.all(color: ColorsManager.white , width: 2) : null
        ),
        child: Center(
          child: Text(
              (isArabicBuild)?"ar":"en",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (isArabicSelected == isArabicBuild)?Color(colorCodes[0]):ColorsManager.white
              ),
          ),
        ),
      ),
    );
  }

}
