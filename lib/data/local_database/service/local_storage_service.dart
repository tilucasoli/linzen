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
  Result<T, LocalStorageError> create(String id, T item) {
    try {
      _box.put(id, item);
      return Success(value: item);
    } catch (e) {
      return Failure(error: LocalStorageError.databaseError);
    }
  }

  // DELETE
  Future<Result<Unit, LocalStorageError>> delete(String id) async {
    try {
      await _box.delete(id);
      return Success.unit();
    } catch (e) {
      return Failure(error: LocalStorageError.databaseError);
    }
  }
}
