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

enum ButtonType {
  primary,
  destructive;

  Color get backgroundColor {
    switch (this) {
      case ButtonType.primary:
        return Color(0xFF2E333A);
      case ButtonType.destructive:
        return Color(0xFFF84F39);
    }
  }
}

class LinzenButton extends StatelessWidget {
  const LinzenButton({
    super.key,
    this.fullWidth = false,
    this.size = ButtonSize.medium,
    this.type = ButtonType.primary,
    required this.onPressed,
    required this.text,
  });

  final bool fullWidth;
  final VoidCallback onPressed;
  final ButtonSize size;
  final String text;
  final ButtonType type;

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
          backgroundColor: WidgetStateProperty.all(type.backgroundColor),
        ),
        child: Text(text),
      ),
    );
  }
}
