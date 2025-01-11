import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool usingText;
  final String? text;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.usingText,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFFEC958), // Orange
        border: Border.all(
          color: const Color(0xFF0E2522), // Black
          width: 1.2,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1.4, 1.8),
            color: Color(0xFF0E2522).withOpacity(1),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: const Color(0xFF0E2522), // Black
          size: 22,
        ),
      ),
    );
  }
}
