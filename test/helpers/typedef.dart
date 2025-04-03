import 'package:mocktail/mocktail.dart';

typedef Stub<T> = When<T> Function(T Function() x);
