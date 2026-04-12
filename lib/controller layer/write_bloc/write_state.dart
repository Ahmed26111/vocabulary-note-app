part of 'write_cubit.dart';

@immutable
sealed class WriteState {
  final String text;
  final bool isArabic;
  final int colorCode;

  const WriteState({
    this.text = "",
    this.isArabic = true,
    this.colorCode = 0XFF4A47A3,
  });
}

final class WriteInitialState extends WriteState {
  const WriteInitialState({super.text, super.isArabic, super.colorCode});
}

final class WriteLoadingState extends WriteState {
  const WriteLoadingState({super.text, super.isArabic, super.colorCode});
}

final class WriteLoadedState extends WriteState {
  const WriteLoadedState({super.text, super.isArabic, super.colorCode});
}

final class WriteErrorState extends WriteState {
  final String message;

  const WriteErrorState({required this.message,super.text, super.isArabic, super.colorCode});
}
