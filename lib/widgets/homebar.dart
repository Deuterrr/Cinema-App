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
        return Container(
          margin: const EdgeInsets.fromLTRB(0, 37, 0, 0),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 253, 247),
            border: const Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 14, 37, 34),
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
                  'Cinema Time',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  )
                ),
              ),

              // Icons Container
              SizedBox(
                width: 82,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // location Icon
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 13.5),
                      width: 36,
                      height: 38,
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
                        iconSize: 19,
                        onPressed: () {
                          locationPanel(context);
                        },
                        icon: const Icon(
                          Icons.location_on_outlined,
                          color: Color.fromARGB(255, 14, 37, 34),
                        ),
                      ),
                    ),

                    // Search Icon
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13.5),
                      width: 36,
                      height: 38,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Searchfieldpages()));
                        },
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Color.fromARGB(255, 14, 37, 34),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Color.fromARGB(255, 255, 253, 247).withOpacity(0.58),
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
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.95,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFDF7),
                    border: Border.all(
                      color: const Color.fromARGB(255, 14, 37, 34),
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
                              "Choose a Movie",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
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
