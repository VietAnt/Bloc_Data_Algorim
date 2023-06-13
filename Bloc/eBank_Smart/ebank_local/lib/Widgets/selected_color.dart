//Todo: SelectedColor
import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Widgets/circle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelecetedColors extends StatelessWidget {
  const SelecetedColors({super.key});

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Circle(
          color: 0xff1977F3,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xff1977F3)),
        ),
        Circle(
          color: 0xffF44235,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xffF44235)),
        ),
        Circle(
          color: 0xff4CAF50,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xff4CAF50)),
        ),
        Circle(
          color: 0xff0A557F,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xff0A557F)),
        ),
        Circle(
          color: 0xff9C27B0,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xff9C27B0)),
        ),
        Circle(
          color: 0xffE91C63,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xffE91C63)),
        ),
        Circle(
          color: 0xff000000,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xff000000)),
        ),
        Circle(
          color: 0xff009688,
          onPressed: () => cardBloc.add(SelectedColorEvent(0xff009688)),
        ),
      ],
    );
  }
}
