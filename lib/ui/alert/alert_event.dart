sealed class AlertEvent {
  const AlertEvent({required this.message});
  final String message;
}

class AlertShow extends AlertEvent {
  const AlertShow({required super.message});
}

class AlertHide extends AlertEvent {
  const AlertHide() : super(message: '');
}
