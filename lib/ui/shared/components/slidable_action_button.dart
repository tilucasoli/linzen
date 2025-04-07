import 'package:flutter/material.dart'; 
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableActionButton extends StatelessWidget {
  const SlidableActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.padding,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return CustomSlidableAction(
      backgroundColor: Color(0xFFEAEBEF),
      onPressed: (context) {
        onPressed();
      },
      padding: padding,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}
