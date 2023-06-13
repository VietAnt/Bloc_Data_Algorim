part of 'card_bloc.dart';

@immutable
class CardState {
  final int color;
  final String category;
  final Color colorCategory;
  final bool isList;
  final int noteLength;

  CardState({
    this.color = 0xff1977F3,
    this.category = "No List",
    this.colorCategory = Colors.redAccent,
    this.isList = true,
    this.noteLength = 0,
  });

  CardState copyWith({
    int? color,
    String? category,
    Color? colorCategory,
    bool? isList,
    int? noteLength,
  }) =>
      CardState(
        color: color ?? this.color,
        category: category ?? this.category,
        colorCategory: colorCategory ?? this.colorCategory,
        isList: isList ?? this.isList,
        noteLength: noteLength ?? this.noteLength,
      );
}
