import 'package:flutter/material.dart';

import 'package:cinema_application/pages/mywishlist.dart';
import 'package:cinema_application/pages/home.dart';
import 'package:cinema_application/pages/mypromos.dart';
import 'package:cinema_application/pages/profile.dart';
import 'package:cinema_application/pages/mytransaction.dart';

import 'package:cinema_application/widgets/buttomnavbar.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomePage(),
    MyPromosPage(),
    MyWishlistPage(),
    MyTransactionPage(),
    MyProfilePage(),
  ];

  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F0E0),
      body: _pages[_selectedIndex],
      bottomNavigationBar:
          Buttomnavbar(onItemTap: _onItemTap),
    );
  }
}