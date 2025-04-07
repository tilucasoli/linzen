import 'dart:async';

import 'package:linzen/ui/alert/alert_event.dart';

class AlertViewModel {
  final _streamController = StreamController<AlertEvent>.broadcast();
  Stream<AlertEvent> get stream => _streamController.stream;

  void dispose() {
    _streamController.close();
  }

  void show(String message) {
    _streamController.add(AlertShow(message: message));
  }

  void hide() {
    _streamController.add(AlertHide());
  }
}
