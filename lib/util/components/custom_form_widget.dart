import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/constants/en_char_type.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';

class CustomFormWidget extends StatefulWidget {
  const CustomFormWidget({super.key, required this.label, required this.globalKey});

  final String label;
  final GlobalKey<FormState> globalKey;

  @override
  State<CustomFormWidget> createState() => _CustomFormWidgetState();
}

class _CustomFormWidgetState extends State<CustomFormWidget> {
  final TextEditingController _editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.globalKey,
        child: TextFormField(
          autofocus: true,
          controller: _editingController,
          decoration: _getInputDecoration(),
          cursorColor: ColorsManager.white,
          style: TextStyle(color: ColorsManager.white),
          maxLines: 2,
          minLines: 1,
          onChanged: (value)=> BlocProvider.of<WriteCubit>(context).updateText(value),
          validator: (value) => _validator(value, context.read<WriteCubit>().state.isArabic),
        ),
    );
  }

  String? _validator(String? value , bool isArabic){
      if(value == null || value.trim().isEmpty){
        return "This field is required";
      }

      for(int i=0;i<value.length;i++){
        EnCharType charType = _getCharType(value.codeUnitAt(i));

        if(charType == EnCharType.eNotValid){
          return "character at ${i+1} is invalid";
        }

        if(charType == EnCharType.eArabic && !isArabic){
          return "character at ${i+1} is not english";
        }

        if(charType == EnCharType.eEnglish && isArabic){
          return "character at ${i+1} is not arabic";
        }

      }

  }

  EnCharType _getCharType(int asciiCode){
    if(asciiCode>=1569 && asciiCode <= 1610){
      return EnCharType.eArabic;
    }
    else if((asciiCode>= 65 && asciiCode <= 90) || (asciiCode>=97 && asciiCode <= 122)){
      return EnCharType.eEnglish;
    }
    else if(asciiCode == 32){
      return EnCharType.eSpace;
    }
    return EnCharType.eNotValid;
  }

  InputDecoration _getInputDecoration() {
    return InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.white , width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.white , width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.red , width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.red , width: 2),
          ),
          labelStyle: TextStyle(color: ColorsManager.white , fontWeight: FontWeight.bold),
          labelText: widget.label,
    );
  }
}
