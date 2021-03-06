const maxInt = (double.infinity is int) ? double.infinity as int : ~minInt;
const minInt = (double.infinity is int) ? -double.infinity as int : (-1 << 63);

extension CaseTest on String {
  bool get isLowerCase => toLowerCase() == this;
  bool get isUpperCase => toUpperCase() == this;
}
