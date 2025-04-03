import 'package:hive_ce/hive.dart';
import 'package:linzen/data/local_database/model/deck.dart';
part 'adaptors.g.dart';

@GenerateAdapters([AdapterSpec<LocalDeck>()])
// ignore: unused_element
class _HiveAdaptors {}
