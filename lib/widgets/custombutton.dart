import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final bool isClicked;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.isClicked, required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 102,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: widget.isClicked ? Color.fromARGB(255, 14, 37, 34) :  Color.fromARGB(255, 255, 253, 247),
          border: Border.all(
            color: widget.isClicked ? Color.fromARGB(255, 14, 37, 34) :  Color.fromARGB(255, 106, 149, 140),
            ),
          boxShadow: [
                  BoxShadow(
                    offset: const Offset(1, 2),
                    color: widget.isClicked ? Colors.black.withOpacity(1) : Color.fromARGB(255, 106, 149, 140),
                  ),
                ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isClicked ? Colors.white : Color.fromARGB(255, 106, 149, 140),
              fontFamily: "Montserrat",
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.12,
            ),
          ),
        ),
      ),
    );
  }
}
