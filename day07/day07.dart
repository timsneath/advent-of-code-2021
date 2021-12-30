import 'dart:io';
import 'dart:math' show min, max;

// Used for part 1 solution -- crabs take same amount of fuel to go each step
int linearFuelAlgorithm(int distance) => distance;

// Used for part 2 solution -- fuel needs increase per Fibonacci
int fibonacciFuelAlgorithm(int distance) {
  var fuel = 0;
  var cost = 1;
  for (int toGo = distance; toGo > 0; toGo--) {
    fuel += cost++;
  }
  return fuel;
}

int fuelToAlignCrabs(
        int pos, List<int> crabsPositions, int Function(int) fuelAlgorithm) =>
    crabsPositions
        .map((e) => fuelAlgorithm((pos - e).abs()))
        .reduce((val, elem) => val + elem);

int minimumNeededFuel(
    List<int> crabsPositions, int Function(int) fuelAlgorithm) {
  final largestPosition =
      crabsPositions.reduce((value, element) => max(value, element));

  final fuel = List<int>.generate(largestPosition,
      ((index) => fuelToAlignCrabs(index, crabsPositions, fuelAlgorithm)));

  return fuel.reduce((value, element) => min(value, element));
}

void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day07/day07.txt';
  final rawData = File(path).readAsLinesSync();

  final crabPositions =
      rawData[0].split(',').map<int>((e) => int.parse(e)).toList();
  final fuelRequired = minimumNeededFuel(crabPositions, fibonacciFuelAlgorithm);
  print('Minimum required: $fuelRequired');
}
