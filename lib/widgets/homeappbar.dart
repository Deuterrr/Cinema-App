import 'package:cinema_application/pages/auth/auth.dart';
import 'package:cinema_application/pages/bookingflow/searchfieldpages.dart';
import 'package:cinema_application/pages/profilepages.dart';
import 'package:flutter/material.dart';
import 'package:cinema_application/pages/accountflow/accountsetup.dart';
import 'package:provider/provider.dart';

class HomeBarButton extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  HomeBarButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        final isLogIn = authProvider.isLoggedIn;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
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
                    // Search Icon
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 13.5),
                      width: 36,
                      height: 40,
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

                    // Profile Icon
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 13.5),
                      width: 36,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
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
                          if (isLogIn) {
                            // Instead of replacing the HomeScreen, navigate within it
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProfilePages()));
                          } else {
                            // Navigate to AccountSetup without replacing the BottomNavbar
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Accountsetup()));
                          }
                        },
                        icon: const Icon(
                          Icons.person_outline_rounded,
                          color: Color.fromARGB(255, 14, 37, 34),
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

  @override
  Size get preferredSize => const Size.fromHeight(64.0);
}
