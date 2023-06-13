import 'dart:core';
import 'package:ebank_local/Model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardState()) {
    on<AddNoteCard>(_addNewCard);
    on<SelectedColorEvent>(_selectedColor);
    on<SelectedCategoryEvent>(_selectedCategory);
    on<ChangedListToGrid>(_changeListToGrid);
    on<UpdateCardEvent>(_updateCard);
    on<DeleteCardEvent>(_deleteCard);
    on<LengthALLCardEvent>(_lengthAllNote);
  }

  //Todo: 1.AddNewCard
  Future<void> _addNewCard(AddNoteCard event, Emitter<CardState> emit) async {
    var box = Hive.box<CardModel>('keepCard');

    var cardModel = CardModel(
      cardHolderName: event.cardHolderName,
      cardNumber: event.cardNumber,
      isCompleted: event.isCompleted,
      expDate: event.expDate,
      cvv: event.cvv,
      color: event.cardColor,
      category: event.category,
      created: DateTime.now(),
    );
    box.add(cardModel);
  }

  //Todo: 2.SelectedColor
  Future<void> _selectedColor(
      SelectedColorEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(color: event.color));
  }

  //Todo: 3.SelectedCategory
  Future<void> _selectedCategory(
    SelectedCategoryEvent event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(
      category: event.category,
      colorCategory: event.colorCategory,
    ));
  }

  //Todo: 4.ChangeListGrid
  Future<void> _changeListToGrid(
    ChangedListToGrid event,
    Emitter<CardState> emit,
  ) async {
    emit(state.copyWith(isList: event.isList));
  }

  //Todo: 5.UpdateCard
  Future<void> _updateCard(
    UpdateCardEvent event,
    Emitter<CardState> emit,
  ) async {
    var box = Hive.box<CardModel>('keepCard');

    var cardModel = CardModel(
      cardHolderName: event.cardHolderName,
      cardNumber: event.cardNumber,
      isCompleted: event.isCompleted,
      expDate: event.expDate,
      cvv: event.cvv,
      color: event.cardColor,
      category: event.category,
      created: DateTime.now(),
    );

    box.putAt(event.index, cardModel);
  }

  //Todo: 6.DeleteCard
  Future<void> _deleteCard(
    DeleteCardEvent event,
    Emitter<CardState> emit,
  ) async {
    var box = Hive.box<CardModel>('keepCard');

    box.delete(event.index);
  }

  //Todo: 7.lengthAllNote
  Future<void> _lengthAllNote(
      LengthALLCardEvent event, Emitter<CardState> emit) async {
    emit(state.copyWith(noteLength: event.length));
  }
}
