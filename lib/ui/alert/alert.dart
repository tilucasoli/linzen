import 'dart:async';

import 'package:elegant_spring_animation/elegant_spring_animation.dart';
import 'package:flutter/material.dart' show Colors, Material;
import 'package:flutter/widgets.dart';
import 'package:linzen/ui/alert/alert_event.dart';
import 'package:linzen/ui/alert/alert_viewmodel.dart';

class AlertProvider extends StatefulWidget {
  const AlertProvider({
    super.key,
    required this.viewModel,
    required this.child,
  });

  final AlertViewModel viewModel;
  final Widget child;

  @override
  State<AlertProvider> createState() => _AlertProviderState();
}

class _AlertProviderState extends State<AlertProvider> {
  late StreamSubscription<AlertEvent> _subscription;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _subscription = widget.viewModel.stream.listen((event) {
      switch (event) {
        case AlertShow():
          _timer = Timer(Duration(seconds: 3), () {
            widget.viewModel.hide();
          });
        case AlertHide():
          _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<AlertEvent>(
        stream: widget.viewModel.stream,
        builder: (context, snapshot) {
          final alert = GestureDetector(
            onTap: () {
              widget.viewModel.hide();
            },
            child: Alert(message: snapshot.data?.message ?? ''),
          );

          return Stack(
            children: [
              widget.child,
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                    left: 24,
                    right: 24,
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 800),
                    switchInCurve: ElegantSpring.smooth,
                    switchOutCurve: Curves.easeOut,
                    reverseDuration: Duration(milliseconds: 300),
                    transitionBuilder:
                        (child, animation) => SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: Offset(0, -2),
                              end: Offset(0, 0),
                            ),
                          ),
                          child: child,
                        ),
                    child:
                        snapshot.data is AlertShow ? alert : SizedBox.shrink(),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Alert extends StatelessWidget {
  const Alert({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key(message),
      height: 55,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Color(0xFFEC375A),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
