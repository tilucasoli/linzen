import 'package:elegant_spring_animation/elegant_spring_animation.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

Future<T?> showLinzenBottomSheet<T>(
  BuildContext context, {
  required String title,
  required WidgetBuilder contentBuilder,
  required WidgetBuilder buttonBuilder,
}) {
  return showModalBottomSheet(
    backgroundColor: Color(0xFFEAEBEF),
    sheetAnimationStyle: AnimationStyle(
      curve: ElegantSpring.smooth,
      duration: Duration(milliseconds: 400),
    ),
    context: context,
    builder:
        (context) => IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: Color(0xFF0F172A),
                        height: 1.4,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      icon: Icon(
                        LucideIcons.x,
                        size: 16,
                        color: Color(0xFF2E333A),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                contentBuilder(context),
                SizedBox(height: 32),
                buttonBuilder(context),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
  );
}
