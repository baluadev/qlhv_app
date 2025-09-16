import 'package:flutter/material.dart';

/// App color palette
class AppColors {
  const AppColors();

  // Grey
  Color get grey900 => const Color(0xFF161b23);
  Color get grey800 => const Color(0xFF1d232e);
  Color get grey700 => const Color(0xFF252d3c);
  Color get grey600 => const Color(0xFF2f3a4c);
  Color get grey500 => const Color(0xFF344054);
  Color get grey400 => const Color(0xFF5d6676);
  Color get grey300 => const Color(0xFF777f8c);
  Color get grey200 => const Color(0xFFa2a7b0);
  Color get grey100 => const Color(0xFFc0c4ca);
  Color get grey50 => const Color(0xFFebecee);
  Color get grey25 => const Color(0xFFfcfcfd);

  Color get white => Colors.white;
  Color get black => Colors.black;

  // Purple
  Color get purple25 => const Color(0xFFfafaff);
  Color get purple50 => const Color(0xFFf4f3ff);
  Color get purple100 => const Color(0xFFebe9fe);
  Color get purple200 => const Color(0xFFd9d6fe);
  Color get purple300 => const Color(0xFFbdb4fe);
  Color get purple400 => const Color(0xFF9b8afb);
  Color get purple500 => const Color(0xFF7a5af8);
  Color get purple600 => const Color(0xFF6938ef);
  Color get purple700 => const Color(0xFF5925dc);
  Color get purple800 => const Color(0xFF4a1fb8);
  Color get purple900 => const Color(0xFF3e1c96);

  // Success (Green)
  Color get success25 => const Color(0xFFf6fef9);
  Color get success50 => const Color(0xFFe8f7f1);
  Color get success100 => const Color(0xFFb8e7d2);
  Color get success200 => const Color(0xFF95dcbc);
  Color get success300 => const Color(0xFF65cc9e);
  Color get success400 => const Color(0xFF47c28b);
  Color get success500 => const Color(0xFF19b36e);
  Color get success600 => const Color(0xFF17a364);
  Color get success700 => const Color(0xFF127f4e);
  Color get success800 => const Color(0xFF0e623d);
  Color get success900 => const Color(0xFF0b4b2e);

  // Error (Red)
  Color get error25 => const Color(0xFFfff8fa);
  Color get error50 => const Color(0xFFfeeeee);
  Color get error100 => const Color(0xFFfdcaca);
  Color get error200 => const Color(0xFFfcb1b1);
  Color get error300 => const Color(0xFFfb8d8d);
  Color get error400 => const Color(0xFFfa7777);
  Color get error500 => const Color(0xFFf95555);
  Color get error600 => const Color(0xFFe34d4d);
  Color get error700 => const Color(0xFFb13c3c);
  Color get error800 => const Color(0xFF892f2f);
  Color get error900 => const Color(0xFF692424);

  // Warning (Yellow / Orange)
  Color get warning25 => const Color(0xFFfff7ec);
  Color get warning50 => const Color(0xFFfff7ec);
  Color get warning100 => const Color(0xFFffefc4);
  Color get warning200 => const Color(0xFFffd9a8);
  Color get warning300 => const Color(0xFFffc880);
  Color get warning400 => const Color(0xFFffbd68);
  Color get warning500 => const Color(0xFFffad42);
  Color get warning600 => const Color(0xFFe89d3c);
  Color get warning700 => const Color(0xFFb57b2f);
  Color get warning800 => const Color(0xFF8c5f24);
  Color get warning900 => const Color(0xFF6b491c);
}

/// Extension để gọi từ context
extension AppColorExtension on BuildContext {
  AppColors get color => const AppColors();
}
