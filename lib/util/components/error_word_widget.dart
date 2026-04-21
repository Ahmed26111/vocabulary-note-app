import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';

class ErrorWordWidget extends StatelessWidget {
  const ErrorWordWidget({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.3,),
        Icon(Icons.error_outline_sharp, color: ColorsManager.red, size: 35,),
        Text(
          message,
          style: TextStyle(
            color: ColorsManager.red,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
