import 'package:cinema_application/widgets/customiconbutton.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String centerText;
  final bool useAppTitle;
  final bool showBottomBorder;
  final bool showBackButton;
  final Widget? trailingButton;

  CustomAppBar({
    this.centerText = '',
    this.showBackButton = true,
    this.showBottomBorder = true,
    this.useAppTitle = false,
    this.trailingButton,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68.0);

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
                CustomIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onPressed: () {
                      Navigator.pop(context);
                    },
                  usingText: false)
              // use title instead
              else if (useAppTitle)
                Text(
                  'Cinema Scope',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0E2522), // Black
                  ),
                )
              else
                const SizedBox(width: 36),

              // Title
              Center(
                child: Text(
                  centerText,
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
}
