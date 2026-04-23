import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget(
      {super.key, required this.colorCodes, required this.text, required this.isArabic,  this.showDeleteButton = false,  this.onPressed});

  final List<int>colorCodes;
  final String text;
  final bool isArabic;
  final bool showDeleteButton;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      decoration: _getBoxDecoration(),
      child: Row(
        spacing: 15,
        children: [
          _getIsArabicWidget(),
          _getWordTextWidget(),
          if(showDeleteButton && onPressed != null)
            IconButton(onPressed: onPressed, icon: Icon(Icons.delete,color: ColorsManager.black,))
        ],
      ),
    );
  }

  Expanded _getWordTextWidget() {
    return Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: ColorsManager.black,
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
          ),
        );
  }

  CircleAvatar _getIsArabicWidget() {
    return CircleAvatar(
          backgroundColor: ColorsManager.black,
          foregroundColor: Color(colorCodes[0]),
          radius: 25,
          child: Text(
            (isArabic)?"ar":"en",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        );
  }

  BoxDecoration _getBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(colors: colorCodes.map((colorCode)=>Color(colorCode)).toList()),
    borderRadius: BorderRadius.circular(15),
  );
}
