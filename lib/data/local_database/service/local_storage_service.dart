import 'package:hive_ce/hive.dart';
import 'package:linzen/shared/result.dart';

enum LocalStorageError implements Exception { databaseError }

class LocalStorageService<T> {
  late final Box<T> _box;

  LocalStorageService(Box<T> box) : _box = box;

  // FETCH
  Future<Result<List<T>, LocalStorageError>> fetchAll() async {
    try {
      final items = _box.values.toList();
      return Success(value: items);
    } catch (e) {
      return Failure(error: LocalStorageError.databaseError);
    }
  }

  // CREATE
  Result<T, LocalStorageError> create(T item) {
    try {
      _box.add(item);
      return Success(value: item);
    } catch (e) {
      return Failure(error: LocalStorageError.databaseError);
    }
  }
}
