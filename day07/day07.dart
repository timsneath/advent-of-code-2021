import 'dart:io';

import 'package:collection/collection.dart';

import '../shared/utils.dart';

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
    crabsPositions.map((e) => fuelAlgorithm((pos - e).abs())).sum;

int minimumNeededFuel(
    List<int> crabsPositions, int Function(int) fuelAlgorithm) {
  final largestPosition = crabsPositions.max;

  final fuel = List<int>.generate(largestPosition,
      ((index) => fuelToAlignCrabs(index, crabsPositions, fuelAlgorithm)));

  return fuel.min;
}

// coverage:ignore-start
void main(List<String> args) {
  final path = args.isNotEmpty ? args[0] : 'day07/day07.txt';
  final rawData = File(path).readAsLinesSync();

  final crabPositions =
      rawData[0].split(',').map<int>((e) => int.parse(e)).toList();
  final fuelRequired = minimumNeededFuel(crabPositions, fibonacciFuelAlgorithm);
  print('Minimum required: $fuelRequired');
}
// coverage:ignore-end
