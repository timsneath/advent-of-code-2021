import 'dart:io';

int calcPowerConsumption(List<String> data) {
  // Convert '01101' to [0, 1, 1, 0, 1]
  final report =
      data.map((event) => event.split('').map((e) => e == '1' ? 1 : 0));

  // Sum all the rows
  final bitTally = report.reduce((a, b) =>
      [for (int i = 0; i < a.length; i++) a.elementAt(i) + b.elementAt(i)]);
  final reportEntries = report.length;

  final bGammaRate = bitTally.map((e) => e * 2 >= reportEntries ? '1' : '0');
  final bEpsilonRate = bitTally.map((e) => e * 2 >= reportEntries ? '0' : '1');

  final gammaRate = int.parse(bGammaRate.join(''), radix: 2);
  final epsilonRate = int.parse(bEpsilonRate.join(''), radix: 2);
  return gammaRate * epsilonRate;
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day03/day03.txt';
  final course = File(path).readAsLinesSync();

  final power = calcPowerConsumption(course);
  print('Power consumption: $power');
}
