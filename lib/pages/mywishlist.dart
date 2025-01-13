import 'package:cinema_application/widgets/customappbar.dart';
import 'package:flutter/material.dart';

class MyWishlistPage extends StatefulWidget {
  const MyWishlistPage({super.key});

  @override
  State<MyWishlistPage> createState() => _MyWishlistPageState();
}

class _MyWishlistPageState extends State<MyWishlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // White
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: CustomAppBar(
          centerText: 'Wishlist',
          showBackButton: false
        ),
      ),
      body: Center(
        child: Text(
          "Favorite Pages"
        ),
      ),
    );
  }
}