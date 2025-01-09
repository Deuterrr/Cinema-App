import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cinema_application/domain/controllers/auth_controller.dart';

import 'package:cinema_application/pages/flows/booking/searchfieldpages.dart';

class HomeBarButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  HomeBarButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return SafeArea(
          child: Container(
            height: preferredSize.height,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: const Color(0xFF94CBC0), // Tosca
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
                Container(
                  decoration: BoxDecoration(
                  ),
                  child: Text(
                    'Cinema Scope',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF0E2522), // Black
                    )
                  ),
                ),

                // Icons Container
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // location Icon
                      Container(
                        width: 38,
                        height: 38,
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
                          iconSize: 19,
                          onPressed: () {
                            locationPanel(context);
                          },
                          icon: const Icon(
                            Icons.location_on_outlined,
                            color: Color(0xFF0E2522), // Black
                          ),
                        ),
                      ),

                      SizedBox(width: 6),

                      // Search Icon
                      Container(
                        width: 38,
                        height: 38,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Searchfieldpages()));
                          },
                          icon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFF0E2522),
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }

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

            // The Page
            Align(
              alignment: Alignment.bottomCenter,

              // Page as Animation
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(0, 1), // Start from bottom
                  end: Offset(0, 0), // End at center
                ).animate(CurvedAnimation(
                  parent: anim1,
                  curve: Curves.easeOut, // Smooth animation curve
                )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF), // White
                    border: Border.all(
                      color: const Color(0xFF0E2522), // Black
                      width: 1.2,
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // The Bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Title
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pick your location",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF0E2522), // Black
                                decorationThickness: 0,
                              ),
                            ),
                          ),
                          // icon
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      // Expanded(
                        
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
