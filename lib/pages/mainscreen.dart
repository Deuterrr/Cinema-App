import 'package:flutter/material.dart';

// import 'package:cinema_application/pages/mywishlist.dart';
import 'package:cinema_application/pages/home.dart';
import 'package:cinema_application/pages/mypromos.dart';
import 'package:cinema_application/pages/profile.dart';
import 'package:cinema_application/pages/mytransaction.dart';

import 'package:cinema_application/widgets/bottomnavbar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomePage(),
    MyPromosPage(),
    // MyWishlistPage(),
    MyTransactionPage(),
    MyProfilePage(),
  ];

  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // to achieve transparent color for custom Bottom Navbar, left BottomNavigationBar as an option, merge it with body instead.
  // the custom bar is not in BottomNavigationBar in the first place, that's why.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevent automatic resizing
      body: Stack(
        children: [
          _pages[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 0), // ignore keyboard adjustment
              child: Bottomnavbar(onItemTap: _onItemTap),
            ),
          ),
        ],
      ),
    );
  }
}