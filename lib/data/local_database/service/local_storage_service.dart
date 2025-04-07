import 'package:hive_ce/hive.dart';
import 'package:result_dart/result_dart.dart';

enum LocalStorageError implements Exception { databaseError }

class LocalStorageService<T extends Object> {
  late final Box<T> _box;

  LocalStorageService(Box<T> box) : _box = box;

  // FETCH
  Future<ResultDart<T, LocalStorageError>> fetch(String id) async {
    try {
      final item = _box.get(id);
      if (item == null) {
        return Failure(LocalStorageError.databaseError);
      }
      return Success(item);
    } catch (e) {
      return Failure(LocalStorageError.databaseError);
    }
  }

  // FETCH ALL
  Future<ResultDart<List<T>, LocalStorageError>> fetchAll() async {
    try {
      final items = _box.values.toList();
      return Success(items);
    } catch (e) {
      return Failure(LocalStorageError.databaseError);
    }
  }

  // CREATE
  AsyncResultDart<T, LocalStorageError> create(String id, T item) async {
    try {
      await _box.put(id, item);
      return Success(item);
    } catch (e) {
      return Failure(LocalStorageError.databaseError);
    }
  }

  // DELETE
  Future<ResultDart<Unit, LocalStorageError>> delete(String id) async {
    try {
      await _box.delete(id);
      return Success.unit();
    } catch (e) {
      return Failure(LocalStorageError.databaseError);
    }
  }

  // UPDATE
  Future<ResultDart<T, LocalStorageError>> update(String id, T item) async {
    try {
      if (_box.containsKey(id)) {
        await _box.put(id, item);
        return Success(item);
      } else {
        return Failure(LocalStorageError.databaseError);
      }
    } catch (e) {
      return Failure(LocalStorageError.databaseError);
    }
  }
}
