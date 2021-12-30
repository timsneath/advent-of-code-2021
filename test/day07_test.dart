import 'package:test/test.dart';

import '../day07/day07.dart';

void main() {
  test('Align sample crabs -- simple algorithm', () {
    const crabs = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14];
    expect(minimumNeededFuel(crabs, linearFuelAlgorithm), equals(37));
  });

  test('Fuel to move distance', () {
    expect(fibonacciFuelAlgorithm(1), equals(1));
    expect(fibonacciFuelAlgorithm(2), equals(3));
    expect(fibonacciFuelAlgorithm(3), equals(6));
  });

  test('Align sample crabs -- complex algorithm', () {
    const crabs = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14];
    expect(minimumNeededFuel(crabs, fibonacciFuelAlgorithm), equals(168));
  });
}
