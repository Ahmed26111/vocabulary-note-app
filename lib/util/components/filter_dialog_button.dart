import 'package:flutter/material.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/util/components/filter_dialog.dart';

class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
        onPressed: (){
          showDialog(context: context, builder: (context)=>FilterDialog());
        },
        icon: Icon(Icons.tune),
        style: IconButton.styleFrom(
          backgroundColor: ColorsManager.white,
          foregroundColor: ColorsManager.black,
          iconSize: 25,
        ),
        tooltip: "filter the words",
    );
  }
}
