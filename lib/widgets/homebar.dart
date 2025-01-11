import 'dart:ui';

import 'package:cinema_application/widgets/customiconbutton.dart';
import 'package:cinema_application/widgets/locationpanel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_application/domain/controllers/auth_controller.dart';
import 'package:cinema_application/pages/flows/booking/searchpage.dart';

class HomeBarButton extends StatefulWidget implements PreferredSizeWidget {
  const HomeBarButton({super.key});

  @override
  State<HomeBarButton> createState() => HomeBarButtonState();

  @override
  Size get preferredSize => Size.fromHeight(68.0);
}

class HomeBarButtonState extends State<HomeBarButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SafeArea(
          child: Container(
            height: widget.preferredSize.height,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF), // White
              border: const Border(
                bottom: BorderSide(
                  color: Color(0xFF0E2522), // Black
                  width: 1.2,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Text(
                  'Cinema Scope',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF0E2522), // Black
                  ),
                ),

                // Icons Container
                Row(
                  children: [
                    // Location Icon
                    CustomIconButton(
                      icon: Icons.location_on_outlined,
                      onPressed: () => locationPanel(context),
                      usingText: true,
                      text: 'Jakarta',
                    ),

                    SizedBox(width: 6),

                    // Search Icon
                    CustomIconButton(
                      icon: Icons.search_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SearchPage())
                        );
                      },
                      usingText: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show location panel with blurred background (biar kece)
  void locationPanel(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "BlurredDialog",
      transitionDuration: Duration(milliseconds: 190),
      pageBuilder: (context, anim1, anim2) {
        return Stack(
          children: [
            // Static blur background
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 3.0),
                child: Container(
                  color: Color(0xFFFFFFFF).withOpacity(0.35),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1),
                  end: Offset(0, 0),
                ).animate(CurvedAnimation(
                  parent: anim1,
                  curve: Curves.easeOut,
                )),

                // The Panel
                child: LocationPanel()
              ),
            ),
          ],
        );
      },
    );
  }
}
