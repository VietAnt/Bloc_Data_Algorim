part of 'general_bloc.dart';

class GeneralEvent extends Equatable {
  const GeneralEvent();

  @override
  List<Object> get props => [];
}

//Todo: IsScrollTopAppBarEvent: Sự_kiện_cuộn
class IsScrollTopAppBarEvent extends GeneralEvent {
  final bool isScroll; //cuộn

  const IsScrollTopAppBarEvent(this.isScroll);
}
