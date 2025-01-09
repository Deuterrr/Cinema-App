import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBottomBorder;
  final bool showBackButton;
  final Widget? trailingButton;

  CustomAppBar({
    required this.title,
    this.showBackButton = true,
    this.showBottomBorder = true,
    this.trailingButton,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF), // Tosca
          border: showBottomBorder
            ? Border(
                bottom: BorderSide(
                  color: const Color(0xFF0E2522), // Black
                  width: 1.2,
                ),
              )
            : null,
        ),
        child: IntrinsicHeight( // Forces Row to take the height of its tallest child
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // Stretch children to match height
            children: [

              // Back Button
              if (showBackButton)
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEC958), // Orange
                    border: Border.all(
                      color: Color(0xFF0E2522), // Black
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
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF0E2522), // Black
                      size: 18,
                    ),
                  ),
                )
              else
                const SizedBox(width: 36),

              // Title
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0E2522), // Black
                  ),
                ),
              ),

              // Optional trailing button
              trailingButton ?? 
                const SizedBox(width: 48),
            ],
          ),
        ),
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
