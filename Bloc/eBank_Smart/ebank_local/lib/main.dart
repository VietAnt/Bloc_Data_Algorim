import 'package:ebank_local/Bloc_State/card/card_bloc.dart';
import 'package:ebank_local/Bloc_State/general/general_bloc.dart';
import 'package:ebank_local/Model/card_model.dart';
import 'package:ebank_local/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CardModelAdapter());
  await Hive.openBox<CardModel>('keepCard');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CardBloc()),
        BlocProvider(create: (context) => GeneralBloc()),
      ],
      child: const MaterialApp(
        title: 'Keep Note - Fraved',
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
