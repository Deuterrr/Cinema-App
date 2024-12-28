import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Buttomnavbar extends StatefulWidget {
  final Function(int) onItemTap;

  const Buttomnavbar({super.key, required this.onItemTap});

  @override
  State<Buttomnavbar> createState() => _ButtomnavbarState();
}

class _ButtomnavbarState extends State<Buttomnavbar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.fromLTRB(36, 5, 36, 10),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 245, 240, 224), //cream flat
          border: const Border(
            top: BorderSide(
              color: Color.fromARGB(255, 14, 37, 34),
              width: 1.2,
            ),
          ),
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildNavIcon('assets/icon/home.svg', 0),
          buildNavIcon('assets/icon/ticket.svg', 1),
          buildNavIcon('assets/icon/favorite.svg', 2),
          buildNavIcon('assets/icon/transaction.svg', 3),
          buildNavIcon('assets/icon/profile.svg', 4),
        ],
      ),
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
          color: _selectedIndex == index ? const Color(0xffFFFDF7) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: SvgPicture.asset(
            path,
            width: 22,
            height: 22,
            colorFilter: _selectedIndex == index
                ? const ColorFilter.mode(Color.fromARGB(255, 220, 85, 94), BlendMode.srcIn)
                : null,
          ),
        ),
      ),
    );
  }
}
