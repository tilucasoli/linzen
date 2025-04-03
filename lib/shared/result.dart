class Result<T, E extends Exception> {
  const Result._();
}

class Success<T, E extends Exception> extends Result<T, E> {
  final T value;

  const Success({required this.value}) : super._();

  factory Success.unit() {
    return Success(value: unit as T);
  }
}

class Failure<T, E extends Exception> extends Result<T, E> {
  final E error;

  Failure({required this.error}) : super._();
}

class Unit {
  const Unit._();
}

const unit = Unit._();
