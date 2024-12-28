import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Widget to build a section with an icon, title, and value
class SectionWithIcon extends StatelessWidget {
  final String title;
  final String value;
  final String icon;

  // Constructor
  const SectionWithIcon({
    required this.title,
    required this.value,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 16),
          child: SvgPicture.asset(
            icon,
            width: 30,
            height: 28,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: "Montserrat-SemiBold",
                fontSize: 12,
                letterSpacing: 0.12,
                color: Colors.black,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontFamily: "Montserrat-Medium",
                color: Color(0xff6A958C),
                letterSpacing: 0.12,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
