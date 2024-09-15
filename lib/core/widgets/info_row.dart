import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoRow extends StatelessWidget {
  final Widget leftWidget;
  final Widget rightWidget;
  final VoidCallback onTap;
  final Color backgroundColor;

  const InfoRow({
    super.key,
    required this.leftWidget,
    required this.rightWidget,
    required this.onTap,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            leftWidget,
            const Spacer(),
            rightWidget,
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/image/arrow-info.svg',
            ),
          ],
        ),
      ),
    );
  }
}
