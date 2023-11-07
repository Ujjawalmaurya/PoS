import 'package:flutter/services.dart';

class Haptics {
  static light() => HapticFeedback.lightImpact();
  static medium() => HapticFeedback.mediumImpact();
  static heavy() => HapticFeedback.heavyImpact();
  static selectionClick() => HapticFeedback.selectionClick();
  static vibrate() => HapticFeedback.vibrate();
}
