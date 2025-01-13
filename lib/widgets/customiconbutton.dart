import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final bool usingText;
  final String? theText;

  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.usingText,
    this.theText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!usingText) {
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
    } else {
      return Container(
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
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            children: [

              Icon(
                icon,
                color: const Color(0xFF0E2522), // Black
                size: 22,
              ),

              SizedBox(width: 8),

              Text(
              theText?.isNotEmpty == true ? theText! : '',
              style: TextStyle(
                color: Color(0xFF0E2522), // Black
                fontWeight: FontWeight.bold,
              ),
            ),
          ]
          ),
        ),
      );
    }
  }
}
