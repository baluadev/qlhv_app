import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

extension StringParseSafe on String {
  int toIntSafe() {
    return int.tryParse(this) ?? 0;
  }

  Widget svg() {
    return SvgPicture.asset(
      this,
      width: 24,
      height: 24,
      colorFilter: const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      ),
    );
  }
}
