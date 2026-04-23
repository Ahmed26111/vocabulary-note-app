import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/util/components/arabic_or_english_widget.dart';
import 'package:vocabulary_note_app/util/components/custom_form_widget.dart';
import 'package:vocabulary_note_app/util/components/done_button.dart';

class UpdateWordDialog extends StatefulWidget {
  const UpdateWordDialog(
      {super.key, required this.isExample, required this.colorCodes, required this.wordIndex});

  final bool isExample;
  final List<int>colorCodes;
  final int wordIndex;

  @override
  State<UpdateWordDialog> createState() => _UpdateWordDialogState();
}

class _UpdateWordDialogState extends State<UpdateWordDialog> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteCubit,WriteState>(
      listener: (context, state) {
        switch (state) {
          case WriteInitialState():break;

          case WriteLoadingState():CircularProgressIndicator();break;

          case WriteLoadedState():Navigator.pop(context);

          case WriteErrorState():ScaffoldMessenger.of(context).showSnackBar(_getSnackBar(state.message));break;

        }
      },
      builder: (context, state) {
        return Dialog(
          child: Container(
            decoration: _getBoxDecoration(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 25,
                children: [
                  ArabicOrEnglishWidget(colorCodes: widget.colorCodes, isArabicSelected: state.isArabic),
                  CustomFormWidget(label: (widget.isExample)?"New Example":"New Similar Word", globalKey: _globalKey),
                  Align(
                    alignment: Alignment.centerRight,
                    child: DoneButton(colorCodes: widget.colorCodes, onTap: (){
                      if(_globalKey.currentState!.validate()){
                        (widget.isExample)
                            ? context.read<WriteCubit>().addExample(wordIndex: widget.wordIndex)
                            : context.read<WriteCubit>().addSimilarWord(wordIndex: widget.wordIndex);
                        context.read<ReadCubit>().getWords();
                      }
                    }),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _getBoxDecoration() => BoxDecoration(
    gradient: LinearGradient(colors: widget.colorCodes.map((colorCode)=> Color(colorCode)).toList()),
    borderRadius: BorderRadius.circular(12),
  );

  SnackBar _getSnackBar(String message) {
    return SnackBar(
      content: Text(message, maxLines: 2, style: TextStyle(color: ColorsManager.white),),
      backgroundColor: ColorsManager.red,
    );
  }

}
