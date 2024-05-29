import 'dart:ffi';

extension DateTimeExtension on DateTime {
  String get prettyDateTime => toString().split(" ")[0];
}

extension DoubleExtension on double {
  bool isBetween(double a, double b) {
    if (this >= a && this <= b) return true;

    return false;
  }
}

extension IntExtension on int {
  int get toMinute {
    return this ~/ 60;
  }

  int get toSecond {
    return this - toMinute * 60;
  }
}
