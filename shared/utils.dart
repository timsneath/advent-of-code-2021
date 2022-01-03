import 'dart:math' as math show min, max;

const maxInt = (double.infinity is int) ? double.infinity as int : ~minInt;
const minInt = (double.infinity is int) ? -double.infinity as int : (-1 << 63);

extension CaseTest on String {
  bool get isLowerCase => toLowerCase() == this;
  bool get isUpperCase => toUpperCase() == this;
}

extension IntReductions on Iterable<int> {
  int get max => reduce((value, element) => math.max(value, element));
  int get min => reduce((value, element) => math.min(value, element));
}
