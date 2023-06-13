part of 'card_bloc.dart';

@immutable
class CardEvent {}

//Todo: 1.AddNoteCard: Thêm_Thẻ
class AddNoteCard extends CardEvent {
  final String cardHolderName;
  final String cardNumber;
  final bool isCompleted;
  final String expDate;
  final String cvv;
  final int cardColor;
  final String category;
  final DateTime created;

  AddNoteCard({
    required this.cardHolderName,
    required this.cardNumber,
    required this.isCompleted,
    required this.expDate,
    required this.cvv,
    required this.cardColor,
    required this.category,
    required this.created,
  });
}

//Todo: 2.SelectedColoEvnt
class SelectedColorEvent extends CardEvent {
  final int color;

  SelectedColorEvent(this.color);
}

//Todo: SelectedCategoryEvent: Lựa_chọn_danh_sách
class SelectedCategoryEvent extends CardEvent {
  final String category;
  final Color colorCategory;

  SelectedCategoryEvent(
    this.category,
    this.colorCategory,
  );
}

//Todo: 4.ChangeListToGrid: Thay_gridview
class ChangedListToGrid extends CardEvent {
  final bool isList;

  ChangedListToGrid(this.isList);
}

//Todo: 5.UpdateCardEvent: Cập_nhật_danh_sách
class UpdateCardEvent extends CardEvent {
  final String cardHolderName;
  final String cardNumber;
  final bool isCompleted;
  final String expDate;
  final String cvv;
  final int cardColor;
  final String category;
  final DateTime created;
  final int index;

  UpdateCardEvent({
    required this.cardHolderName,
    required this.cardNumber,
    required this.isCompleted,
    required this.expDate,
    required this.cvv,
    required this.cardColor,
    required this.category,
    required this.created,
    required this.index,
  });
}

//Todo: 6.DeleteCardEvent: Xóa_Thẻ
class DeleteCardEvent extends CardEvent {
  final int index;

  DeleteCardEvent(this.index);
}

//Todo: 7.lengthAllCardEvent
class LengthALLCardEvent extends CardEvent {
  final int length;

  LengthALLCardEvent(this.length);
}
