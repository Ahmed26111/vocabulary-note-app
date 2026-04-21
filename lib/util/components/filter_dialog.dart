import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulary_note_app/constants/colors_manager.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_language_filter.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorted_filter.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorted_filter.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorted_filter.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorting_type.dart';
import 'package:vocabulary_note_app/constants/enum_filters/en_sorting_type.dart';
import 'package:vocabulary_note_app/controller%20layer/read_bloc/read_cubit.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCubit,ReadState>(
      builder: (context,state)=> Dialog(
        insetPadding: const EdgeInsets.all(10),
        backgroundColor: ColorsManager.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 7,
            children: [
              _getLabelText("Language"),
              _getLanguageFilterField(context, state),
              _getLabelText("Sorted By"),
              _getSortedByFilterField(context, state),
              _getLabelText("Sorting Type"),
              _getSortingTypeFilterField(context, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getSortingTypeFilterField(BuildContext context, ReadState state) {
    return _getFilterField(
              labels: [
                "Ascending",
                "Descending",
              ],
              onTaps: [
                    ()=>context.read<ReadCubit>().updateSortingType(EnSortingType.eAscending) ,
                    ()=>context.read<ReadCubit>().updateSortingType(EnSortingType.eDescending) ,
              ],
              activationCondition: [
                (state.sortingType == EnSortingType.eAscending),
                (state.sortingType == EnSortingType.eDescending),
              ],
    );
  }

  Widget _getSortedByFilterField(BuildContext context, ReadState state) {
    return _getFilterField(
              labels: [
                "Time",
                "Word Length",
              ],
              onTaps: [
                    ()=>context.read<ReadCubit>().updateSortedBy(EnSortedFilter.eByTime) ,
                    ()=>context.read<ReadCubit>().updateSortedBy(EnSortedFilter.eByWordLenght),
              ],
              activationCondition: [
                (state.sortedFilter == EnSortedFilter.eByTime),
                (state.sortedFilter == EnSortedFilter.eByWordLenght),
              ],
    );
  }

  Widget _getLanguageFilterField(BuildContext context, ReadState state) {
    return _getFilterField(
              labels: [
                "Arabic",
                "English",
                "All"
              ],
              onTaps: [
                    ()=>context.read<ReadCubit>().updateLanguageFilter(EnLanguageFilter.eArabic) ,
                    ()=>context.read<ReadCubit>().updateLanguageFilter(EnLanguageFilter.eEnglish) ,
                    ()=>context.read<ReadCubit>().updateLanguageFilter(EnLanguageFilter.eAll) ,
              ],
              activationCondition: [
                (state.languageFilter == EnLanguageFilter.eArabic),
                (state.languageFilter == EnLanguageFilter.eEnglish),
                (state.languageFilter == EnLanguageFilter.eAll),
              ],
    );
  }

  Widget _getFilterField({
    required List<String> labels,
    required List<VoidCallback> onTaps,
    required List<bool> activationCondition,
  })
  {
    if(labels.length == onTaps.length && onTaps.length == activationCondition.length){
      return LayoutBuilder(
          builder: (context,constraints){
            const double spacing = 8.0;

            final double itemWidth = (constraints.maxWidth-(spacing*(labels.length-1)))/labels.length;

            return Wrap(
              spacing: spacing,
              runSpacing: 4,
              direction: Axis.horizontal,
              children: [
                for(int i = 0; i < labels.length; i++)
                  SizedBox(
                    height: 40,
                    width: itemWidth,
                    child: OutlinedButton(
                        onPressed: onTaps[i],
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: (activationCondition[i])?ColorsManager.white:ColorsManager.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            )
                        ),
                        child: Center(
                          child: Text(
                            labels[i],
                            style: TextStyle(
                              fontSize: 13, // Slightly smaller font for responsiveness
                              fontWeight: FontWeight.w500,
                              color: (activationCondition[i])?ColorsManager.black:ColorsManager.white,
                            ),
                          ),
                        )
                    ),
                  ),
              ],
            );
          }
      );
    }
    throw Exception("you should put the same number of elements in the three arguments");
  }

  Text _getLabelText(String value){
    return Text(
      value,
      style: TextStyle(
        color: ColorsManager.white,
        fontWeight: FontWeight.bold,
        fontSize: 22
      ),
    );
  }
}
