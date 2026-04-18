part of 'write_cubit.dart';

@immutable
sealed class WriteState {
  final String text;
  final bool isArabic;
  final List<int> colorCodes;

  const WriteState({
    this.text = "",
    this.isArabic = true,
    this.colorCodes = const [0xFFFF9A86 , 0xFFFFD6A6],
  });
}

final class WriteInitialState extends WriteState {
  const WriteInitialState({super.text, super.isArabic, super.colorCodes});
}

final class WriteLoadingState extends WriteState {
  const WriteLoadingState({super.text, super.isArabic, super.colorCodes});
}

final class WriteLoadedState extends WriteState {
  const WriteLoadedState({super.text, super.isArabic, super.colorCodes});
}

final class WriteErrorState extends WriteState {
  final String message;

  const WriteErrorState({required this.message,super.text, super.isArabic, super.colorCodes});
}
