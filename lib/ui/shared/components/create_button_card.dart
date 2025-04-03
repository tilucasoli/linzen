import 'package:flutter/material.dart';

class CreateButtonCard extends StatelessWidget {
  const CreateButtonCard({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          ),
          TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              padding: WidgetStateProperty.all(
                EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              ),
              foregroundColor: WidgetStateProperty.all(Color(0xFF2E333A)),
              textStyle: WidgetStateProperty.all(
                TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
              ),
              backgroundColor: WidgetStateProperty.all(Color(0xFFEAEBEF)),
            ),
            child: Row(
              spacing: 6,
              children: [
                Text('Create'),
                Icon(Icons.add, size: 20, color: Color(0xFF2E333A)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
