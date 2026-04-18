import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/controller%20layer/write_bloc/write_cubit.dart';
import 'package:vocabulary_note_app/util/components/arabic_or_english_widget.dart';
import 'package:vocabulary_note_app/util/components/colors_widget.dart';
import 'package:vocabulary_note_app/util/components/custom_form_widget.dart';
import 'package:vocabulary_note_app/util/components/done_button.dart';

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<WriteCubit, WriteState>(
        builder: (context, state) =>
            AnimatedContainer(
              duration: Duration(milliseconds: 750),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: state.colorCodes.map((colorCode)=>Color(colorCode)).toList()),
                borderRadius: BorderRadius.circular(15)
              ),
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  10 , vertical: 5),
                    child: ArabicOrEnglishWidget(colorCodes: state.colorCodes, isArabicSelected: state.isArabic),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  10 , vertical: 5),
                    child: ColorsWidget(activeColorCodes: state.colorCodes),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  10 , vertical: 5),
                    child: CustomFormWidget(label: "New Word", globalKey: _globalKey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:  10 , vertical: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: DoneButton(
                          colorCodes: state.colorCodes,
                          onTap: (){
                             if(_globalKey.currentState!.validate()){
                               //Todo add word model in data base
                             }
                          }
                      ),
                    ),
                  ),

                ],
              ),
            ),
      ),
    );
  }
}
