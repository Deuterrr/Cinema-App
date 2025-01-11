import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool isEmptyText;
  final bool suffixIcon;

  SearchField({
    Key? key,
    required this.controller,
    required this.isEmptyText,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: isEmptyText ? 500 : 500,
            child: Container(
              height: 42,
              padding: const EdgeInsets.fromLTRB(17, 4, 6, 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // White
                border: Border.all(
                  color: const Color(0xFF0E2522), // Black
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(0.8, 1.8),
                    color: Color(0xFF0E2522), // Black
                  ),
                ],
              ),
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0E2522), // Black
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: "Search",
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A6761), // Dark Tosca
                  ),
                  border: InputBorder.none,
                  suffixIcon: isEmptyText
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SvgPicture.asset(
                            'assets/icon/Search.svg',
                            width: 15,
                            height: 15,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {
                              controller.clear();
                            },
                            child: const Icon(
                              Icons.cancel,
                              size: 24,
                              color: Color(0xFF0E2522), // Black
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
