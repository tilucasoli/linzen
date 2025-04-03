import 'package:flutter_test/flutter_test.dart';
import 'package:linzen/shared/result.dart';

TypeMatcher<Failure> isAFailureEnum<T>(Enum enumCase) => isA<Failure>().having(
  (failure) => failure.error,
  'error',
  equals(enumCase),
);
