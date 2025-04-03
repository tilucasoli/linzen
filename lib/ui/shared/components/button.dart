import 'package:flutter/material.dart';

enum ButtonSize {
  small,
  medium,
  large;

  EdgeInsets get padding {
    switch (this) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12, vertical: 8);
      case ButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.fullWidth = false,
    this.size = ButtonSize.medium,
    required this.onPressed,
  });

  final bool fullWidth;
  final VoidCallback onPressed;
  final ButtonSize size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          padding: WidgetStateProperty.all(size.padding),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          textStyle: WidgetStateProperty.all(
            TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Color(0xFF2E333A)),
        ),
        child: Text('Start Session'),
      ),
    );
  }
}
