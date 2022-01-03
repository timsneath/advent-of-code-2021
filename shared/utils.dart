const maxInt = (double.infinity is int) ? double.infinity as int : ~minInt;
const minInt = (double.infinity is int) ? -double.infinity as int : (-1 << 63);

extension LowerCase on String {
  bool get isLowerCase => toLowerCase() == this;
}

extension Sum on List<int> {
  int sum() => reduce((value, element) => value + element);
}
