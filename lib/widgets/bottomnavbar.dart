import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bottomnavbar extends StatefulWidget {
  final Function(int) onItemTap;

  const Bottomnavbar({super.key, required this.onItemTap});

  @override
  State<Bottomnavbar> createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<Bottomnavbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 22),
      child: Container(
        height: 62,
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        decoration: BoxDecoration(
          color: Color(0xFFFFFAEA), // Soft Cream
          borderRadius: BorderRadius.circular(38),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0.7, 1.8),
              color: Color(0xFF0E2522).withOpacity(1),
            ),
          ],
          border: Border.all(
            color: Color(0xFF0E2522), // Black
            width: 1.8,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNavIcon('assets/icon/home.svg', 0),
            SizedBox(width: 36),
            buildNavIcon('assets/icon/ticket.svg', 1),
            SizedBox(width: 36),
            // buildNavIcon('assets/icon/favorite.svg', 2),
            buildNavIcon('assets/icon/transaction.svg', 2),
            SizedBox(width: 36),
            buildNavIcon('assets/icon/profile.svg', 3),
          ],
        ),
      )
    );
  }

  Widget buildNavIcon(String path, int index) {
    return GestureDetector(
      onTap: () {
        widget.onItemTap(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: _selectedIndex == index ? const Color(0xFFFFD580) : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: SvgPicture.asset(
            path,
            width: 22,
            height: 22,
            colorFilter: _selectedIndex == index
                ? const ColorFilter.mode(Color(0xFFCD404A), BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }
}
