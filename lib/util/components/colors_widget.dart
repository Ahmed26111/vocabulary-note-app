import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';

class ColorsWidget extends StatelessWidget {
   ColorsWidget({super.key, required this.activeColorCodes});

  final List<int> activeColorCodes ;

  final List<List<int>> _colorCodes = [
    [0xFFFF9A86 , 0xFFFFD6A6],
    [0xFFBDA6CE , 0xFF9B8EC7],
    [0xFF408A71 , 0xFFB0E4CC],
    [0xFF6367FF , 0xFF8494FF],
    [0xFFD53E0F , 0xFFFF7070],
    [0xFF355872 , 0xFF9CD5FF],
    [0xFFEE6983 , 0xFFFFC4C4],
    [0xFF0ABAB5 , 0xFFADEED9],
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
          itemBuilder: (context , index)=> _getColorItemDesign(_colorCodes[index] , context),
          separatorBuilder: (_,_) => SizedBox(width: 7,),
          itemCount: _colorCodes.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _getColorItemDesign(List<int> colorCodes , BuildContext context){
    final bool isSelected =  listEquals<int>(activeColorCodes, colorCodes);
    return InkWell(
      onTap: ()=> BlocProvider.of<WriteCubit>(context).updateColorCode(colorCodes),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: colorCodes.map((colorCode) => Color(colorCode)).toList() ),
          border: (isSelected)?  BoxBorder.all(color: ColorsManager.white , width: 2 ): null,
        ),
        width: 50,
        height: 50,
        child: (isSelected)?Center(child: Icon(Icons.done , color: Colors.white,)) : null,
      ),
    );
  }


}
