sealed class Result<T, E extends Exception> {
  const Result._();

  Result<NewSuccess, E> map<NewSuccess>(NewSuccess Function(T) f);

  Result<T, NewError> mapError<NewError extends Exception>(
    NewError Function(E) f,
  );
}

class Success<T, E extends Exception> extends Result<T, E> {
  final T value;

  const Success({required this.value}) : super._();

  factory Success.unit() {
    return Success(value: unit as T);
  }

  @override
  Result<NewSuccess, E> map<NewSuccess>(NewSuccess Function(T) f) {
    return Success(value: f(value));
  }

  @override
  Result<T, NewError> mapError<NewError extends Exception>(
    NewError Function(E) f,
  ) {
    return Success(value: value);
  }
}

class Failure<T, E extends Exception> extends Result<T, E> {
  final E error;

  Failure({required this.error}) : super._();

  @override
  Result<NewSuccess, E> map<NewSuccess>(NewSuccess Function(T) f) {
    return Failure(error: error);
  }

  @override
  Result<T, NewError> mapError<NewError extends Exception>(
    NewError Function(E) f,
  ) {
    return Failure(error: f(error));
  }
}

class Unit {
  const Unit._();
}

const unit = Unit._();
