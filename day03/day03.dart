import 'dart:io';

Iterable<Iterable<int>> convertRawData(List<String> rawData) =>
    rawData.map((event) => event.split('').map((e) => e == '1' ? 1 : 0));

int calcPowerConsumption(Iterable<Iterable<int>> report) {
  // Sum all the rows
  final bitTally = report.reduce((a, b) =>
      [for (int i = 0; i < a.length; i++) a.elementAt(i) + b.elementAt(i)]);
  final reportEntries = report.length;

  final bGammaRate = bitTally.map((e) => e * 2 >= reportEntries ? '1' : '0');
  final bEpsilonRate = bitTally.map((e) => e * 2 >= reportEntries ? '0' : '1');

  final gammaRate = int.parse(bGammaRate.join(), radix: 2);
  final epsilonRate = int.parse(bEpsilonRate.join(), radix: 2);
  return gammaRate * epsilonRate;
}

int calcOxygenGeneratorRating(Iterable<Iterable<int>> report) {
  final rows = report.toList();

  for (var bit = 0; rows.length > 1; bit++) {
    // Find the most common value in a given column by summing the column and
    // seeing if the total is half or more. If so, the most common value is 1,
    // if not, it's 0.
    final columnSum = rows
        .map((e) => e.elementAt(bit))
        .reduce((value, element) => value + element);
    final mostCommonValue = columnSum * 2 >= rows.length ? 1 : 0;

    rows.removeWhere((element) => element.elementAt(bit) != mostCommonValue);
  }

  return int.parse(rows.first.join(), radix: 2);
}

int calcCO2ScrubberRating(Iterable<Iterable<int>> report) {
  final rows = report.toList();

  for (var bit = 0; rows.length > 1; bit++) {
    // Find the least common value in a given column by summing the column and
    // seeing if the total is more than half. If so, the least common value is
    // 0, if not, it's 1.
    final columnSum = rows
        .map((e) => e.elementAt(bit))
        .reduce((value, element) => value + element);
    final leastCommonValue = columnSum * 2 >= rows.length ? 0 : 1;

    rows.removeWhere((element) => element.elementAt(bit) != leastCommonValue);
  }

  return int.parse(rows.first.join(), radix: 2);
}

int calcLifeSupportRating(Iterable<Iterable<int>> report) =>
    calcOxygenGeneratorRating(report) * calcCO2ScrubberRating(report);

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day03/day03.txt';
  final rawData = File(path).readAsLinesSync();

  // Convert '01101' to [0, 1, 1, 0, 1]
  final report = convertRawData(rawData);

  final power = calcPowerConsumption(report);
  print('Power consumption: $power');

  final lifeSupport = calcLifeSupportRating(report);
  print('Life support rating: $lifeSupport');
}
// coverage:ignore-end
