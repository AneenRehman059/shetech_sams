// colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // Convert RGBA to Flutter Color (RGBO)
  static Color fromRGBA(int r, int g, int b, double opacity) {
    return Color.fromRGBO(r, g, b, opacity);
  }

  // Define your color palette
  static final appColor = fromRGBA(142, 62, 99, 1); // #2196F3
  static final bgColor = fromRGBA(236, 242, 255, 1);  // #F5F5F5
  static final mediumGrey = fromRGBA(158, 158, 158, 1.0); // #9E9E9E
  static final darkGrey = fromRGBA(97, 97, 97, 1.0);      // #616161
  static final whiteBg = fromRGBA(255, 255, 255, 1.0);      // #FFFFFF
  static final black = fromRGBA(0, 0, 0, 1.0);
  static final grey = fromRGBA(217, 217, 217, 1);
  static final yellowColor = fromRGBA(255, 255, 0, 1.0);

  static final b1 = fromRGBA(141, 90, 186, 1.0);
  static final b2= fromRGBA(137, 22, 82, 1.0);
  static final b3 = fromRGBA(225, 120, 197, 1.0);

}