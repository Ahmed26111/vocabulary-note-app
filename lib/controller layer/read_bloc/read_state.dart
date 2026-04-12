part of 'read_cubit.dart';

@immutable
sealed class ReadState {
  final EnLanguageFilter languageFilter;
  final EnSortedFilter sortedFilter ;
  final EnSortingType sortingType ;
  final List<WordModel> words;

  const ReadState({
    this.words =const [],
    this.languageFilter = EnLanguageFilter.eAll,
    this.sortedFilter = EnSortedFilter.eByTime,
    this.sortingType = EnSortingType.eDescending,
  });


}

final class ReadInitialState extends ReadState {
  const ReadInitialState({
    super.words,
    super.languageFilter,
    super.sortedFilter,
    super.sortingType
  });
}

final class ReadLoadingState extends ReadState {
  const ReadLoadingState({
    super.words,
    super.languageFilter,
    super.sortedFilter,
    super.sortingType
  });
}

final class ReadLoadedState extends ReadState {
  const ReadLoadedState({
    super.words,
    super.languageFilter,
    super.sortedFilter,
    super.sortingType
  });


                    //? For Testing first
  /// ReadLoadedState copyWith({List<WordModel>? words ,EnLanguageFilter? languageFilter  ,EnSortedFilter? sortedFilter ,EnSortingType ? sortingType }){
  ///   return ReadLoadedState(
  ///     words: words ?? this.words,
  ///     languageFilter: languageFilter ?? this.languageFilter ,
  ///     sortedFilter: sortedFilter ?? this.sortedFilter ,
  ///     sortingType: sortingType ?? this.sortingType
  ///   );
  /// }
}

final class ReadErrorState extends ReadState {
  final String message;

  const ReadErrorState({
    required this.message,
    super.words,
    super.languageFilter,
    super.sortedFilter,
    super.sortingType
  });
}
