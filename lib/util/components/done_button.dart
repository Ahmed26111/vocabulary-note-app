import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, required this.colorCodes, required this.onTap});

  final List<int> colorCodes;
  final VoidCallback onTap;
  
  @override
  Widget build(BuildContext context) {
    return FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: ColorsManager.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )
        ),
        child: Text("Done",style: TextStyle(fontWeight: FontWeight.bold , color: Color(colorCodes[0])),),
    );
  }
}
