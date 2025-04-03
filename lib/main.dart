import 'package:flutter/material.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:linzen/data/local_database/model/deck.dart';
import 'package:linzen/data/local_database/model/hive_adaptors/adaptors.dart';
import 'package:provider/provider.dart';

import 'data/local_database/service/local_storage_service.dart';
import 'data/repository/deck.dart';
import 'ui/home/viewmodel/deck_viewmodel.dart';
import 'ui/home/widgets/home_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LocalDeckAdapter());
  final deckBox = await Hive.openBox<LocalDeck>('deck');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) => DeckViewModel(
                deckRepository: DeckRepository(
                  localDeckStorageService: LocalStorageService(deckBox),
                ),
              ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomeScreen(viewModel: context.read()),
    );
  }
}
