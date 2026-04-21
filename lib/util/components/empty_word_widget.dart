import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';

class EmptyWordWidget extends StatelessWidget {
  const EmptyWordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
        Icon(Icons.menu, color: ColorsManager.white, size: 35),
        Text(
          "No words yet..",
          style: TextStyle(
            color: ColorsManager.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
