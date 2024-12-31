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
    return Container(
      height: preferredSize.height,
      margin: const EdgeInsets.fromLTRB(0, 37, 0, 0),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 253, 247),
        border: showBottomBorder
          ? Border(
              bottom: BorderSide(
                color: const Color.fromARGB(255, 14, 37, 34),
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
                margin: const EdgeInsets.symmetric(vertical: 13.5),
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 196, 64),
                  border: Border.all(
                    color: const Color.fromARGB(255, 14, 37, 34),
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(1, 2),
                      color: Colors.black.withOpacity(1),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color.fromARGB(255, 14, 37, 34),
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
                    color: Color.fromARGB(255, 14, 37, 34),
                  ),
                ),
              ),

            // Optional trailing button
            trailingButton ?? 
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
